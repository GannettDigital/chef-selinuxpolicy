require_relative 'spec_helper'

case $node['platform_version'].to_i
  when 5
    pkgs = [ 'policycoreutils', 'selinux-policy-devel', 'make' ]
  when 6
    pkgs = [ 'policycoreutils-python', 'selinux-policy', 'make' ]
  when 7
    pkgs = [ 'policycoreutils-python', 'selinux-policy-devel', 'make' ]
  else
    pkgs = [ 'policycoreutils-python', 'selinux-policy', 'make' ]
end

pkgs.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe command("/usr/sbin/semanage port -l | grep -P 'tcp\\s+1080'") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('http_port_t').before('1080') }
end