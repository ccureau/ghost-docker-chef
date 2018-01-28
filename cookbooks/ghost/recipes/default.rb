#
# Cookbook:: ghost
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'ghost::_install_ghost'
include_recipe 'ghost::_config_supervisord'
