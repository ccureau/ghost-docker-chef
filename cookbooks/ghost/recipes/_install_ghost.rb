#
# Cookbook:: ghost
# Recipe:: _config_supervisord
#
# Copyright:: 2018, Chris Cureau, All Rights Reserved.

execute 'install ghost-cli globally' do
  command 'npm install -g ghost-cli'
end

execute 'download and configure ghost' do
  cwd node['ghost']['homedir']
  command "ghost install --no-stack --no-start --no-setup --db mysql --dbhost #{node['mariadb']['host']} --dbuser #{node['mariadb']['user']} --dbpass #{node['mariadb']['pass']} --dbname #{node['mariadb']['database']} --url http://localhost:2368"
end

execute 'ghost database migrations' do
  cwd node['ghost']['homedir']
  command "#{node['ghost']['homedir']}/current/node_modules/.bin/knex-migrator-migrate --init --mgpath #{node['ghost']['homedir']}/current"
end
