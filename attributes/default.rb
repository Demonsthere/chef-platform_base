default['platform_base']['packages'] = %w(less htop vim mc curl zip unzip ncdu telnet rsync netcat-openbsd net-tools screen)
default['platform_base']['java']['versions'] = [
  { 'version' => '7', 'pkg' => 'openjdk-7-jdk' },
  { 'version' => '8', 'pkg' => 'openjdk-8-jdk' }
]
default['platform_base']['java']['defaultversion'] = '8'