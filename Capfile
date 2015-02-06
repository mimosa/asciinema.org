# -*- encoding: utf-8 -*-

require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rbenv'

set :rbenv_type, :user # or :system
set :rbenv_ruby, '2.1.2p95'

set :application, 'asciicasts.cn'
set :repo_url, 'git@coding.net:asciicasts/asciicasts.cn.git'

set :deploy_to, '/home/deploy/asciicasts.cn'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

namespace :deploy do

  desc '重启服务。'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end