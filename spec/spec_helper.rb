require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

RSpec.configure do |config|
  config.hiera_config = 'spec/fixtures/hiera/hiera.yaml'
  config.before :each do
    # Ensure that we don't accidentally cache facts and environment between
    # test cases.  This requires each example group to explicitly load the
    # facts being exercised with something like
    # Facter.collection.loader.load(:ipaddress)
    Facter.clear
    Facter.clear_messages
  end
  config.default_facts = {
    :environment   => 'rp_env',
    :git_version   => '2.1.2',
    :git_html_path => '/usr/share/doc/git-1.7.1',
    :git_exec_path => '/usr/libexec/git-core',
  }
end
