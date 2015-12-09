lock '3.4.0'

set :application, 'footopic'
set :repo_url, 'http://github.com/footopic/web-prototype.git'
# set :repo_url, 'git@github.com:footopic/web-prototype.git'
set :deploy_to, '/var/www/footopic'
set :scm, :git
set :log_level, :debug
set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads import}
set :linked_files, %w{.env}

set :default_stage, 'staging'


set :use_sudo, true

set :deploy_user, 'footopic'
set :keep_releases, 5

set :bundle_jobs, 4

set :branch, 'develop'

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

# rbenvs
set :rbenv_ruby_version, '2.2.3'
set :rbenv_type, :system # :system or :user
set :rbenv_ruby, '2.2.3'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :default_env, {
    path: '/usr/local/bin:$PATH'
}

# npm
set :npm_target_path, -> { release_path.join('node_modules') }
set :npm_flags, '--production --silent --no-spin'
set :npm_roles, :all
set :npm_env_variables, {}

# SSHKit.conifg
SSHKit.config.command_map[:rake] = 'bundle exec rake'

before 'deploy:migrate', 'deploy:copy_sqlite'
after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :copy_sqlite do
    on roles(:app) do
      execute "cp #{current_path}/db/production.sqlite3 #{release_path}/db/"
    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'db_seed must be run only one time right after the first deploy'
  task :db_seed do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end

namespace :files do

  task :secrets do
    # esa archive
    on roles(:app) do
      upload! '.env', "#{fetch(:shared_dir)}/.env"
    end

  end

  task :esa_import do
    on roles(:all) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          # upload! 'import/articles', "#{fetch(:shared_dir)}/import/", recursive: true
          execute :rake, 'archive:import_esa_io'
        end
      end
    end
  end
end

namespace :remote_rake do
  desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=db:seed_fu
  task :invoke do
    on roles(:all) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, ENV['task']
        end
      end
    end
  end
end
