group 'docker' do
  action :manage
  members node[:platform_base][:docker][:users]
end
