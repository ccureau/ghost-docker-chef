#
# Cookbook:: ghost
# Recipe:: _config_supervisord
#
# Copyright:: 2018, Chris Cureau, All Rights Reserved.

bash 'install ghost-cli globally' do
  code <<-EOH
    npm install -g yarn
    yarn global add ghost-cli
  EOH
end

user node['ghost']['user'] do
  home node['ghost']['homedir']
  manage_home true
  action :create
end

bash 'download and configure ghost' do
  cwd node['ghost']['homedir']
  code <<-EOH
    ghost install --no-stack --no-start --no-setup --db mysql --dbhost #{node['mariadb']['host']} --dbuser #{node['mariadb']['user']} --dbpass #{node['mariadb']['pass']} --dbname #{node['mariadb']['database']} --url http://localhost:2368
  EOH
end

bash 'ghost database migrations' do
  cwd node['ghost']['homedir']
  code <<-EOH
    #{node['ghost']['homedir']}/current/node_modules/.bin/knex-migrator-migrate --init --mgpath #{node['ghost']['homedir']}/current
  EOH
end
