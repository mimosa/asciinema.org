# -*- encoding: utf-8 -*-

unless Settings[:omniauth].nil?
  OmniAuth.config.full_host = Settings.omniauth.delete('host')
  OmniAuth.config.logger = Rails.logger
  OmniAuth.config.on_failure = OmniauthCallbacksController.action(:failure)

  Rails.application.config.middleware.use OmniAuth::Builder do
    Settings.omniauth.each do |name, opts|
      provider name, opts.delete('key'), opts.delete('secret'), opts 
    end
  end
end