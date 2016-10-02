#
# Cookbook Name:: chef-platform_base
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
if node[:platform] == 'debian'
  include_recipe 'platform_base::apt_config'
else
  log 'Ubuntu detected. Not touching source lists.'
end

include_recipe 'apt'

execute 'update sources' do
  command 'apt-get update'
  action :run
end

include_recipe 'platform_base::lsb'
include_recipe 'platform_base::bashrc'
include_recipe 'platform_base::java'
include_recipe 'git'

node[:platform_base][:packages].each do |pkg|
  package pkg do
    action :upgrade
  end
end

include_recipe 'platform_base::groups'

script 'Reset old docker connections' do
  interpreter 'bash'
  user 'root'
  only_if { node[:platform] == 'debian' }
  code <<-EOH
    service docker stop
    systemctl unmask docker.service
    systemctl unmask docker.socket
    service docker restart
  EOH
end

execute 'set-bash-shell' do
  command 'sudo update-alternatives --install /bin/sh sh /bin/bash 300'
end
