require_relative '../spec_helper'

# ----------------------------
# open jvm setup
# ----------------------------

default = '7'

["openjdk-#{default}-jdk", 'java-common'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

jdk_dir = "java-#{default}-openjdk-amd64"

describe file('/usr/lib/jvm/default-java') do
  it { should be_linked_to "/usr/lib/jvm/#{jdk_dir}" }
end

describe file('/etc/alternatives/java') do
  it { should be_linked_to "/usr/lib/jvm/#{jdk_dir}/jre/bin/java" }
end

describe file('/etc/alternatives/javac') do
  it { should be_linked_to "/usr/lib/jvm/#{jdk_dir}/bin/javac" }
end

describe command('bash -l -c set | grep JAVA_HOME') do
  its(:stdout) { should match '/usr/lib/jvm/default-java' }
end
