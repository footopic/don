include_recipe './attributes/default.rb'

user 'www-data'

package 'nginx'

service 'nginx' do
  action :enable
end

template '/etc/nginx/nginx.conf' do
  source "./templates/nginx.conf"
  owner 'root'
  group 'root'
  mode '0600'
  notifies :restart, 'service[nginx]'
end

remote_directory '/etc/nginx/conf.d' do
  source "./files/#{node['app_name']}"
  owner 'root'
  group 'root'
  notifies :restart, 'service[nginx]'
end
