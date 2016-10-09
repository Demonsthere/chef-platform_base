#
# Cookbook Name:: chef-platform_base
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
include_recipe 'platform_base::apt_config'

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

include_recipe 'platform_base::docker'

include_recipe 'platform_base::groups'

execute 'set-bash-shell' do
  command 'sudo update-alternatives --install /bin/sh sh /bin/bash 300'
end

include_recipe 'platform_base::cleanup'
