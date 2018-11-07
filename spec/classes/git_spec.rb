require 'spec_helper'

describe 'git' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      case os_facts[:osfamily]
      when 'Suse'
        context 'defaults' do
          it do
            should contain_package('git-core')
          end
        end

        context 'with package_manage set to false' do
          let(:params) do
            {
              package_manage: false
            }
          end

          it do
            should_not contain_package('git-core')
          end
        end

        context 'with package_ensure => latest' do
          let(:params) do
            {
              package_ensure: 'latest'
            }
          end

          it do
            should contain_package('git-core').with(
              'ensure' => 'latest'
            )
          end
        end

      else
        context 'defaults' do
          it { should contain_package('git') }
        end

        context 'with package_manage set to false' do
          let(:params) do
            {
              package_manage: false
            }
          end

          it { should_not contain_package('git') }
        end

        context 'with a custom git package name' do
          let(:params) do
            {
              package_name: 'gitolite'
            }
          end

          it { should contain_package('gitolite') }
        end

        context 'with package_ensure => latest' do
          let(:params) do
            {
              package_ensure: 'latest'
            }
          end
          it {
            should contain_package('git').with(
              'ensure' => 'latest'
            )
          }
        end
      end

      context 'with configs' do
        let(:params) do
          {
            configs: {
              'user.name' => { 'value' => 'test' },
              'user.email' => 'test@example.com'
            }
          }
        end

        it do
          should contain_git__config('user.name')
          should contain_git__config('user.email')
        end
      end

      context 'with configs and configs defaults' do
        let(:params) do
          {
            configs: {
              'core.filemode' => false
            },
            configs_defaults: {
              'scope' => 'system'
            }
          }
        end

        it {
          should contain_git__config('core.filemode').with(
            'value' => false,
            'scope' => 'system'
          )
        }
      end
    end
  end
end
