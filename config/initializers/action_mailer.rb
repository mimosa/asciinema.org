# -*- encoding: utf-8 -*-

unless Settings[:action_mailer].nil?
  c = Settings.action_mailer

  Rails.application.configure do
    config.action_mailer.delivery_method = c.method.to_sym
    case c.method
    when 'smtp'
      config.action_mailer.smtp_settings = c.smtp.symbolize_keys
    end
    config.action_mailer.default_url_options = c.default_url.symbolize_keys
  end
end