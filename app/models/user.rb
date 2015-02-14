# -*- encoding: utf-8 -*-

class User < Account

  InvalidEmailError = Class.new(StandardError)

  has_many :authorizations, dependent: :destroy
  has_many :expiring_tokens, dependent: :destroy

  has_many :asciicasts, dependent: :destroy
  has_many :devices, dependent: :destroy

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true, if: :email
  validates :username, uniqueness: { case_sensitive: false },
                       format: { with: /\A[-a-z0-9\p{Han}]+\Z/ },
                       length: { minimum: 2, maximum: 16 },
                       if: :username

  scope :with_username, -> { where('username IS NOT NULL') }

  before_create :generate_access_token

  class << self
    def for_email!(email)
      raise InvalidEmailError if email.blank?

      self.where(email: email).first_or_create!

    rescue ActiveRecord::RecordInvalid => e
      if e.record.errors[:email].present?
        raise InvalidEmailError
      else
        raise e
      end
    end

    def for_username!(username)
      with_username.where(username: username).first!
    end

    def for_udid(udid)
      return nil if udid.blank?

      joins(:devices).where( devices: { udid: udid } ).first
    end

    def for_udid!(udid, username)
      for_udid(udid) || create_with_udid(udid, username)
    end
    # 
    def for_access_token(access_token)
      self.find_by(single_access_token: access_token)
    end
    # 
    def for_oauth(auth)
      return nil if auth.blank?
      joins(:authorizations).where( authorizations: { uid: auth.uid, provider: auth.provider } ).first
    end
    #
    def for_oauth!(auth, username)
      for_oauth(auth) || create_with_oauth(auth, username)
    end
    # 注册设备，创建用户
    def create_with_udid(udid, username)
      return nil if udid.blank?
      username = nil if username.blank?

      transaction do |tx|
        user = User.create!(temporary_username: username)
        user.devices.create!(udid: udid)
        user
      end
    end
    # 通过第三方登录，创建用户
    def create_with_oauth(auth, user = nil)
      return nil if auth.blank?

      # 获取用户标识
      identity = Authorization.find_for_oauth(auth)
      # 已关联用户 或 指定关联用户
      user = identity.user_id? ? identity.user : user
      
      email = auth.info.email
      username = auth.extra.raw_info.nickname || auth.extra.raw_info.name
      # 无关联用户，创建用户
      if user.nil?
        user = if email.present?
          self.for_email!(email)
        else
          self.create!( temporary_username: username )
        end

        if user.new_record?
          user.update_attributes(username: username, temporary_username: nil)
        end

      end

      # 关联第三方登录信息
      if identity.user_id != user.id
        identity.update_attributes(user_id: user.id)
      end
      user
    end

    def generate_token
      SecureRandom.urlsafe_base64
    end

    def null
      self.new(temporary_username: 'anonymous')
    end
  end

  def confirmed?
    email.present?
  end

  def username=(value)
    value ? super(value.strip) : super
  end

  def email=(value)
    value ? super(value.strip) : super
  end

  def theme
    theme_name.presence && Theme.for_name(theme_name)
  end

  def connect_device(udid)
    device = Device.for_udid(udid)

    if device
      device.reassign_to(self)
    else
      device = devices.create!(udid: udid)
    end

    device
  end
  # 合并用户
  def merge_to(target_user)
    self.class.transaction do |tx|
      asciicasts.update_all(user_id: target_user.id, updated_at: Time.now)
      devices.update_all(user_id: target_user.id, updated_at: Time.now)
      destroy
    end
  end

  def asciicast_count
    asciicasts.count
  end

  def asciicasts_excluding(asciicast, limit)
    asciicasts.where('id <> ?', asciicast.id).order('RAND()').limit(limit)
  end

  def paged_asciicasts(page, per_page)
    asciicasts.
      includes(:user).
      order("created_at DESC").
      paginate(page, per_page)
  end

  def admin?
    CFG.admin_ids.include?(id)
  end

  def first_login?
    expiring_tokens.count == 1
  end

  private

  def generate_access_token
    begin
      self[:single_access_token] = self.class.generate_token
    end while User.exists?(single_access_token: self[:single_access_token])
  end

end
