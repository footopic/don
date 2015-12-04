include_recipe './attributes/default.rb'

%w{
  git
  gcc
  libssl-dev
  libreadline-dev
  curl
  build-essential
}.each do |pkg|
  package pkg
end

git "/home/#{node['ruby_user']}/.rbenv" do
  repository 'https://github.com/sstephenson/rbenv.git'
  user "#{node['ruby_user']}"
end

directory "/home/#{node['ruby_user']}/.rbenv/plugins" do
  owner "#{node['ruby_user']}"
  group "#{node['ruby_user']}"
end

git "/home/#{node['ruby_user']}/.rbenv/plugins/ruby-build" do
  repository 'https://github.com/sstephenson/ruby-build.git'
  user "#{node['ruby_user']}"
end

template "/home/#{node['ruby_user']}/.bashrc" do
  source "./templates/.bashrc"
  owner node['ruby_user']
  group node['ruby_user']
  mode '0644'
end

execute "Install ruby ver#{node['ruby_version']}" do
  command "~/.rbenv/bin/rbenv install #{node['ruby_version']}"
  user "#{node['ruby_user']}"
  not_if "~/.rbenv/bin/rbenv versions | grep #{node['ruby_version']}"
end

execute "Set global ruby ver#{node['ruby_version']}" do
  command "~/.rbenv/bin/rbenv global #{node['ruby_version']}"
  user "#{node['ruby_user']}"
end
