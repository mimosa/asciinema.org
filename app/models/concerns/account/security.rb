# -*- encoding: utf-8 -*-
require 'utils/crypt' unless String.method_defined?(:decrypt)

class Account
  module Security
    extend ActiveSupport::Concern
    included do

      validates :account, length: { in: 6..30 }, unless: :login?
      validates :password, length: { within: 6..16 }, presence: true, confirmation: true, if: :password_required
      validates :password_confirmation, length: { within: 6..16 }, presence: true, if: :password_required

      index reset_token: 1
      index remember_token: 1

      attr_accessor :account, :password, :password_confirmation

      
      before_validation :login_required   # 判定注册是否合法
      before_validation :encrypt_password # 当存在电邮或手机时，验证密码
    end

    module ClassMethods
      def find_with_login(login, password)
        return :bad_request unless (login.present? && password.present?)

        user = case login
        when VALID_REGEX[:mobile] # 手机
          where(mobile: /#{login}/i).first
        when VALID_REGEX[:email] # 电邮
          where(email: /#{login}/i).first
        else
          :not_allowed
        end

        UserAuthenticator.new(user).authenticate(password)
      end
    end

    def password_clean
      self.crypted_password.decrypt(self.salt)
    end

    private

    # Password setter generates salt and crypted_password
    def encrypt_password
      if self.password.present?
        self.salt = secure_token
        self.crypted_password = self.password.to_s.encrypt( self.salt )
      end
    end

    def login_required
      return true if login?
      case self.account.to_s
      when VALID_REGEX[:mobile]
        self.mobile = "#{self.account}".downcase
      when VALID_REGEX[:email]
         self.email = "#{self.account}".downcase
      else
        self.errors.add(:account, '仅支持：手机或Email！')
      end
    end

    def password_required
      self.crypted_password.blank? || self.password.present? if login?
    end
  end
end