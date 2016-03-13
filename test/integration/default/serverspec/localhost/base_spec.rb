require_relative '../spec_helper'

# ----------------------------
# base specs
# ----------------------------#

pkgs = %w(less htop vim mc curl zip unzip ncdu telnet rsync netcat-openbsd net-tools screen git lsb-release)
users = %w(vagrant)

pkgs.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe process('docker') do
  it { should be_running }
end

users.each do |usr|
  describe user(usr) do
    it { should belong_to_group 'docker' }
  end
end
