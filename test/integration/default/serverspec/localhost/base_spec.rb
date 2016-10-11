require_relative '../spec_helper'

# ----------------------------
# base specs
# ----------------------------#

pkgs = %w(less htop vim mc curl zip unzip ncdu telnet rsync netcat-openbsd net-tools screen git lsb-release)

pkgs.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
