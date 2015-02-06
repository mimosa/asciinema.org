# -*- encoding: utf-8 -*-

unless Settings[:action_mailer].nil?
  config = Settings.action_mailer
  case Settings.action_mailer.method
  when 'mandrill'
    MandrillDm.configure do |c|
      c.api_key = config.mandrill.api_key
    end
  end
end