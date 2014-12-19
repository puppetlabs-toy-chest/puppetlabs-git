require "spec_helper"

describe Facter::Util::Fact do
  before {
    Facter.clear
  }

  describe "git_version" do
    context 'vanilla git' do
      it do
        git_version_output = 'git version 2.1.2'
        Facter::Util::Resolution.expects(:exec).with("git --version 2>&1").returns(git_version_output)
        Facter.fact(:git_version).value.should == "2.1.2"
      end
    end

    context 'git with hub' do
      it do
        git_version_output = <<-EOS
git version 2.1.2
hub version 1.12.2
        EOS
        Facter::Util::Resolution.expects(:exec).with("git --version 2>&1").returns(git_version_output)
        Facter.fact(:git_version).value.should == "2.1.2"
      end
    end
  end
end