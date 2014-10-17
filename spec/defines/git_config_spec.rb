require 'spec_helper'

describe 'git::config', :type => :define do
  before :each do
    ENV["HOME"] = '/home/JCDenton'
  end
  context 'has working default parameters' do
    let(:title) { 'user.name' }
    let(:params) {
      {
        :value => 'JC Denton',
      }
    }
    it do
      should contain_exec("git config --global user.name 'JC Denton'").with(
        'environment' => 'HOME=/home/JCDenton',
        'path'        => ["/usr/bin", "/bin", "/usr/local/bin"],
        'user'        => 'root',
        'unless'      => "git config --global --get user.name 'JC Denton'",
      )
    end
  end
  context 'allows you to specify a user' do
    let(:title) { 'user.email' }
    let(:params) {
      {
        :user  => 'jcdenton',
        :value => 'jcdenton@UNATCO.com',
      }
    }
    it do
      should contain_exec("git config --global user.email 'jcdenton@UNATCO.com'").with(
        'environment' => 'HOME=/home/JCDenton',
        'path'        => ["/usr/bin", "/bin", "/usr/local/bin"],
        'user'        => 'jcdenton',
        'unless'      => "git config --global --get user.email 'jcdenton@UNATCO.com'",
      )
    end
  end
end