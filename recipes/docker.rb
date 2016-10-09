package 'docker.io' do
  action :purge
end

package 'libgnutls-deb0-28' do
  action :remove
end

execute 'Add docker key' do
  command 'apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D'
  action :run
end

cookbook_file 'docker.list' do
  path '/etc/apt/sources.list.d/docker.list'
  mode '0644'
  owner 'root'
  group 'root'
  action :create_if_missing
end

execute 'apt-get update' do
  action :run
end

package 'docker-engine' do
  action :install
end
