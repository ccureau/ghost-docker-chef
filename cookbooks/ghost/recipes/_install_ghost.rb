#
# Cookbook:: ghost
# Recipe:: _config_supervisord
#
# Copyright:: 2018, Chris Cureau, All Rights Reserved.

bash 'install yarn' do
  code <<-EOH
    npm install -g yarn
  EOH
end

%w{ ghost-cli knex-migrator }.each do |mod|
  bash "install #{mod} globally" do
    code <<-EOH
      yarn global add #{mod}
    EOH
  end
end

user node['ghost']['user'] do
  home node['ghost']['homedir']
  manage_home false
  action :create
end

directory node['ghost']['homedir'] do
  owner node['ghost']['user']
  group node['ghost']['group']
  action :create
end

bash 'download and configure ghost' do
  cwd node['ghost']['homedir']
  code <<-EOH
    ghost install --no-stack --no-start --no-setup --db mysql --dbhost #{node['mariadb']['host']} --dbuser #{node['mariadb']['user']} --dbpass #{node['mariadb']['pass']} --dbname #{node['mariadb']['database']} --url http://127.0.0.1:2368
    chown -R #{node['ghost']['user']}:#{node['ghost']['group']} #{node['ghost']['homedir']}/content
    ghost config --db mysql --dbhost #{node['mariadb']['host']} --dbuser #{node['mariadb']['user']} --dbpass #{node['mariadb']['pass']} --dbname #{node['mariadb']['database']} --url http://127.0.0.1:2368
    #{node['ghost']['homedir']}/current/node_modules/.bin/knex-migrator-migrate --init --mgpath #{node['ghost']['homedir']}/current
  EOH
end

# bash 'fix permissions' do
#   code <<-EOH
#     chown -R #{node['ghost']['user']}:#{node['ghost']['group']} #{node['ghost']['homedir']}/content
#   EOH
# end
#
# bash 'ghost database migrations' do
#   cwd node['ghost']['homedir']
#   code <<-EOH
#     #{node['ghost']['homedir']}/current/node_modules/.bin/knex-migrator-migrate --init --mgpath #{node['ghost']['homedir']}/current
#   EOH
# end
