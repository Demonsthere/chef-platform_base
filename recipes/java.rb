apt_package 'java-common'

apt_package node['platform_base']['java']['binary'] do
  timeout 3000
  options '--allow-unauthenticated -o APT::Force-LoopBreak=yes'
  default_release 'jessie' if node[:platform] == 'debian'
end

jdk_dir = "java-#{node['platform_base']['java']['version']}-openjdk-amd64"
link '/usr/lib/jvm/default-java' do
  to "/usr/lib/jvm/#{jdk_dir}"
end

bash 'set default java version' do
  user 'root'
  code "update-java-alternatives -s #{jdk_dir} || true"
end

directory '/etc/profile.d' do
  mode 0755
end

file '/etc/profile.d/jdk.sh' do
  content 'export JAVA_HOME=/usr/lib/jvm/default-java'
  mode 0755
end
