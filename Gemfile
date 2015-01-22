# -*- encoding: utf-8 -*-
source 'http://ruby.taobao.org'

gem 'rails',                '4.1.5'
gem 'rails-i18n'
gem 'settingslogic'
gem 'sass-rails',           '~> 4.0.3'
gem 'coffee-rails',         '~> 4.0.1'
gem 'uglifier',             '>= 2.3.1'
gem 'jquery-rails',         '~> 3.0.4'

gem 'mysql2' # 数据库
gem 'carrierwave-qiniu'
gem 'kaminari',             '~> 0.14.1'
gem 'bugsnag',              '~> 2.2.1'
gem 'draper',               '~> 1.3.1'
gem 'fog',                  '~> 1.9.0'
gem 'simple_form',          '~> 3.0.2'
gem 'simple_form_bootstrap3', '~> 0.2.6'
# 队列
gem 'sidekiq'
gem 'sidekiq_monitor'
%w(scheduler status).each do |g|
  gem "sidekiq-#{g}"
end
gem 'thin',                 '~> 1.5.0'
gem 'open4',                '~> 1.3.0'
gem 'redcarpet',            '~> 2.2.2'
gem 'slim',                 '~> 2.0.0'
gem 'dotenv-rails',         '~> 0.8'
gem 'sinatra',              '~> 1.4.3', :require => false
gem 'active_model_serializers', '~> 0.8.1'
gem 'yajl-ruby',            '~> 1.1.0', :require => 'yajl'
gem 'newrelic_rpm'
gem 'virtus',               '~> 1.0.1'
gem 'warden',               '~> 1.2.3'
gem 'pundit',               '~> 0.3.0'
gem 'rack-robustness',      '~> 1.1.0'
gem 'rack-rewrite',         '~> 1.5.0'

group :development do
  gem 'quiet_assets',   '~> 1.0.1'
  # Better errors handler
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano',     '~> 2.15'
  gem 'capistrano-ext', '~> 1.2'
  gem 'foreman',        '~> 0.63.0'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test, :development do
  gem 'pry-rails',     '~> 0.3.2'
  gem 'rspec-rails',   '~> 3.0.2'
  gem 'cane',          '~> 2.5.2'
  gem 'jasmine-rails', '~> 0.4.5'
  gem 'timecop',       '~> 0.7.1'
end

group :test do
  gem "rake",               '~> 10.0.4'
  gem 'factory_girl_rails', '~> 4.2.0'
  gem 'capybara',           '~> 2.4.1'
  gem 'poltergeist',        '~> 1.5.0'
  gem 'database_cleaner',   '~> 1.0.1'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-inotify',         '~> 0.9.0'
  gem 'simplecov',          '~> 0.7.1', require: false
  gem 'shoulda-matchers'
  gem 'coveralls',          require: false
  gem 'rspec-activemodel-mocks'
end

group :production do
  gem 'unicorn',               '~> 4.7'
  gem 'dalli',                 '~> 2.6.2'
  gem 'unicorn-worker-killer', '~> 0.4.2'
end
