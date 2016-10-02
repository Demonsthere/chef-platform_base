default['platform_base']['packages'] = %w(less htop vim mc curl zip unzip ncdu telnet rsync netcat-openbsd net-tools screen docker.io)
default['platform_base']['java']['version'] = '7'
default['platform_base']['java']['binary'] = "openjdk-#{node[:platform_base][:java][:version]}-jdk"
default['platform_base']['docker']['users'] = %w(vagrant)
