user 'vagrant' do
  action :create
  manage_home true
  only_if { node[:platform] == 'ubuntu' }
end

group 'docker' do
  action :create
  members node['platform_base']['docker']['users']
end
