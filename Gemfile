# -*- encoding: utf-8 -*-
source 'http://ruby.taobao.org'

gem 'rails',                '4.1.5'
gem 'sass-rails',           '~> 4.0.3'
gem 'coffee-rails',         '~> 4.0.1'
gem 'uglifier',             '>= 2.3.1'

gem 'draper',               '~> 1.3.1'
gem 'simple_form',          '~> 3.0.2'
gem 'simple_form_bootstrap3', '~> 0.2.6'

#
#
#
# I18n
gem 'rails-i18n'
gem 'i18n-js'
# Config
gem 'settingslogic'
# 队列
gem 'sidekiq'
gem 'sidekiq_monitor'
%w(scheduler status).each do |g|
  gem "sidekiq-#{g}"
end
# Redis
gem 'em-hiredis', require: false
gem 'hiredis'
gem 'redis', require:  ['redis', 'redis/connection/hiredis']
%w(namespace objects).each do |g|
  gem "redis-#{g}"
end
gem 'active_interaction' # 替换 virtus
gem 'mysql2' # 数据库
gem 'activeuuid' # UUID
gem 'foreigner' # 外键
gem 'bower-rails' # 资源文件管理
gem 'carrierwave-qiniu'
gem 'kaminari' # 分页
gem 'enumerize' # Enumeration fields
# 监控
gem 'newrelic_rpm'
gem 'skylight'
group :development do
  gem 'quiet_assets'
  # Better errors handler
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  # 部署
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  # 容器
  gem 'thin'
  # 调试
  gem 'byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'
  gem 'rack-mini-profiler'
  gem 'colorize_unpermitted_parameters'
end
gem 'six' # 权限，替换 pundit
gem 'mandrill_dm' # 邮件
gem 'goatmail' # 邮件预览
# 第三方登录
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-linkedin-oauth2'
gem 'omniauth-wechat-oauth2'
gem 'social-share-button' # 分享按钮
#
#
#

gem 'open4',                '~> 1.3.0'
gem 'redcarpet',            '~> 2.2.2'
gem 'slim',                 '~> 2.0.0'
gem 'dotenv-rails',         '~> 0.8'
gem 'sinatra',              '~> 1.4.3', :require => false
gem 'active_model_serializers', '~> 0.8.1'
gem 'yajl-ruby',            '~> 1.1.0', :require => 'yajl'
gem 'warden',               '~> 1.2.3'
gem 'pundit',               '~> 0.3.0'
gem 'rack-robustness',      '~> 1.1.0'
gem 'rack-rewrite',         '~> 1.5.0'
group :development do
  gem 'foreman',        '~> 0.63.0'
  gem 'spring'
  gem 'spring-commands-rspec'
end
group :test, :development do
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
  gem 'rb-inotify',         '~> 0.9.0'
  gem 'simplecov',          '~> 0.7.1', require: false
  gem 'shoulda-matchers'
  gem 'coveralls',          require: false
  gem 'rspec-activemodel-mocks'
end
group :production do
  gem 'therubyracer'
end