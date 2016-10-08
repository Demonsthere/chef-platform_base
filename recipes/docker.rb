apt_repository 'dockerproject' do
  uri 'https://apt.dockerproject.org/repo'
  components ['main']
  distribution 'debian-jessie'
  keyserver 'hkp://p80.pool.sks-keyservers.net:80'
  key '58118E89F3A912897C070ADBF76221572C52609D'
end

execute 'apt-get update' do
  action :run
end

package 'docker.io' do
  action :purge
end

package 'docker-engine' do
  action :install
end
