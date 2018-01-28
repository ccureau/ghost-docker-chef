default['ghost']['user'] = 'ghost'
default['ghost']['group'] = 'ghost'
default['ghost']['homedir'] = '/opt/ghost-blog'
default['ghost']['download_url'] = 'https://ghost.org/zip/ghost-latest.zip'

default['mariadb']['host'] = ENV['MARIADB_HOST']
default['mariadb']['database'] = ENV['MARIADB_DB']
default['mariadb']['user'] = ENV['MARIADB_USER']
default['mariadb']['pass'] = ENV['MARIADB_PASS']
