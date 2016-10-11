group 'docker' do
  action :create
  members node[:platform_base][:docker][:users]
end
