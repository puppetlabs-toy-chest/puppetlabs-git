require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'git_html_path' do
    context 'windows' do
      it do
        Facter.fact(:osfamily).stubs(:value).returns('windows')
        Facter.fact(:git_version).stubs(:value).returns('1.7.1')
        Facter::Util::Resolution.expects(:exec).with('git --html-path 2>nul').returns('windows_path_change')
        Facter.fact(:git_html_path).value.should == 'windows_path_change'
      end
    end

    context 'non-windows' do
      it do
        Facter.fact(:osfamily).stubs(:value).returns('RedHat')
        Facter.fact(:git_version).stubs(:value).returns('1.7.1')
        Facter::Util::Resolution.expects(:exec).with('git --html-path 2>/dev/null').returns('/usr/share/doc/git-1.7.1')
        Facter.fact(:git_html_path).value.should == '/usr/share/doc/git-1.7.1'
      end
    end

    context 'no git present' do
      it do
        Facter.fact(:git_version).stubs(:value).returns(nil)
        Facter.fact(:git_html_path).value.should be_nil
      end
    end
  end
end
