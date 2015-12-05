# deploy 時に自動で bundle install
require 'bundler/capistrano'

# deploy 時に自動で rake assets:precompile
load 'deploy/assets'

# アプリケーションの設定
set :application, 'don'
set :domain, 'don.cps.im.dendai.ac.jp'
set :rails_env, 'production'

set :repository, 'file://.'
set :branch, 'develop'

set :deploy_via, :copy
set :deploy_to, '/var/www/undersky.co'
set :use_sudo, false

server domain, :app, :web

# 再起動後に古い releases を cleanup
after 'deploy:restart', 'deploy:cleanup'

# Unicorn 用の設定
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_bin, 'unicorn'
set :unicorn_pid, '/tmp/unicorn.undersky.co.pid'

# Unicorn 用のデーモン操作タスク
def remote_file_exists?(full_path)
  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip == 'true'
end

def process_exists?(pid_file)
  capture("ps -p `cat #{pid_file}`; true").strip.split("\n").size == 2
end

namespace :deploy do
  desc 'Start Unicorn'
  task :start, roles: :app, except: {no_release: true} do
    if remote_file_exists? unicorn_pid
      if process_exists? unicorn_pid
        logger.important 'Unicorn is already running!', 'Unicorn'
        next
      else
        run "rm #{unicorn_pid}"
      end
    end

    logger.important 'Starting Unicorn...', 'Unicorn'
    run "cd #{current_path} && bundle exec unicorn -c #{unicorn_config} -E #{rails_env} -D"
  end

  desc 'Stop Unicorn'
  task :stop, :roles => :app, :except => {:no_release => true} do
    if remote_file_exists? unicorn_pid
      if process_exists? unicorn_pid
        logger.important 'Stopping Unicorn...', 'Unicorn'
        run "kill -s QUIT `cat #{unicorn_pid}`"
      else
        run "rm #{unicorn_pid}"
        logger.important 'Unicorn is not running.', 'Unicorn'
      end
    else
      logger.important 'No PIDs found. Check if unicorn is running.', 'Unicorn'
    end
  end

  desc 'Reload Unicorn'
  task :reload, :roles => :app, :except => {:no_release => true} do
    if remote_file_exists? unicorn_pid
      logger.important 'Reloading Unicorn...', 'Unicorn'
      run "kill -s HUP `cat #{unicorn_pid}`"
    else
      logger.important 'No PIDs found. Starting Unicorn...', 'Unicorn'
      run "cd #{current_path} && bundle exec unicorn -c #{unicorn_config} -E #{rails_env} -D"
    end
  end

  desc 'Restart Unicorn'
  task :restart, :roles => :app, :except => {:no_release => true} do
    stop
    start
  end
end