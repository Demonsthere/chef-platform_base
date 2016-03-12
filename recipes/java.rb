version_exists = false
node['platform_base']['java']['versions'].each do |java_version|
  version_exists = true if java_version['version'] == node['platform_base']['java']['defaultversion']
end

fail 'Attributes messed up: [\'platform_base\'][\'java\'][\'defaultversion\'] not found in [\'platform_base\'][\'java\'][\'versions\'].' \
  unless version_exists

apt_package 'java-common'

node['platform_base']['java']['versions'].each do |java_version|
  apt_package java_version['pkg'] do
    timeout 3000
    options '--allow-unauthenticated -o APT::Force-LoopBreak=yes'
    default_release 'testing'
  end
end

jdk_dir = "java-#{node['platform_base']['java']['defaultversion']}-openjdk-amd64"
link '/usr/lib/jvm/default-java' do
  to "/usr/lib/jvm/#{jdk_dir}"
end

# set java alternative but ignore all errors as some files
# seem to be missing for java jdk 7
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
