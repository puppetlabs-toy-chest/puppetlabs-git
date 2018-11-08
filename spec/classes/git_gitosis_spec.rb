require 'spec_helper'

describe 'git::gitosis' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'defaults' do
        it do
          should contain_package('gitosis')
          should contain_class('git')
          should create_class('git::gitosis')
        end
      end
    end
  end
end
