# -*- encoding: utf-8 -*-

class Authorization < ActiveRecord::Base
  extend Enumerize
  enumerize :provider, in: Settings.omniauth.keys, scope: true, predicates: true unless Settings[:omniauth].nil?

  belongs_to :user

  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.find_for_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_create!
  end
end