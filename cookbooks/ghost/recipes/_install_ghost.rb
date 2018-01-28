#
# Cookbook:: ghost
# Recipe:: _config_supervisord
#
# Copyright:: 2018, Chris Cureau, All Rights Reserved.

user 'ghost' do
  comment 'Ghost blog user'
  home node['ghost']['homedir']
  manage_home true
  shell '/bin/false'
  action :create
end

execute 'download ghost bundle' do
  command "curl -L -o /tmp/ghost-latest.zip #{node['ghost']['download_url']}"
end

bash 'unpack ghost' do
  cwd node['ghost']['homedir']
  code <<-EOH
    unzip /tmp/ghost-latest.zip
    chown -R #{node['ghost']['user']}:#{node['ghost']['group']} #{node['ghost']['homedir']}
    rm -rf /tmp/ghost-latest.zip
  EOH
end

execute 'install dependencies for ghost' do
  cwd node['ghost']['homedir']
  command 'npm install --production'
end
