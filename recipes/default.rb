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

node['platform_base']['packages'].each do |pkg|
  package pkg
end

bash 'set_editor_nano_root' do
  user 'root'
  cwd '/root'
  code <<-EOF
  echo 'export EDITOR=nano' >> .bashrc
  EOF
  not_if 'grep \'EDITOR=nano\' /root/.bashrc', 'user' => 'root'
end
