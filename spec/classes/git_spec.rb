require 'spec_helper'

describe 'git' do

  context 'defaults' do
    it { should contain_package('git') }
  end

  context 'with a custom git package name' do
    let(:params) {
      {
        :package_name => 'gitolite',
      }
    }
    it { should contain_package('gitolite') }
  end

end
