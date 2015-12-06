lock '3.4.0'

set :application, 'footopic'
set :repo_url, 'http://github.com/footopic/web-prototype.git'
# set :repo_url, 'git@github.com:footopic/web-prototype.git'
set :deploy_to, "/var/www/footopic"
set :scm, :git
set :log_level, :debug
set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle .env}
set :default_stage, 'staging'


set :use_sudo, true

set :deploy_user, 'footopic'
set :keep_releases, 5

set :bundle_jobs, 4

set :branch, 'develop'

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# rbenvs
set :rbenv_ruby_version, '2.2.3'
set :rbenv_type, :system # :system or :user
set :rbenv_ruby, '2.2.3'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
