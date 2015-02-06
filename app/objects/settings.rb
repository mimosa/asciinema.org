# -*- encoding: utf-8 -*-

class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
  suppress_errors Rails.env.production?

  def omniauth_providers
    self.omniauth.except('host').keys unless self[:omniauth].blank?
  end

  def current_redis(space=:tmp)
    Redis::Namespace.new( space,
      redis: Redis.new( url: redis.url, driver: redis.driver.to_sym ) # 
    )
  end
end