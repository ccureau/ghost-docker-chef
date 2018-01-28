#
# Cookbook:: ghost
# Recipe:: _config_supervisord
#
# Copyright:: 2018, Chris Cureau, All Rights Reserved.

template '/etc/supervisord.d/ghost.ini' do
  source 'ghost.ini.erb'
  mode 0600
  owner 'root'
  group 'root'
end
