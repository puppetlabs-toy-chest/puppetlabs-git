require 'spec_helper'

describe Puppet::Type.type(:git_config).provider(:git_config) do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:resource) do
        Puppet::Type.type(:git_config).new(
          key: 'user.email',
          value: 'john.doe@example.com'
        )
      end
      let(:provider) { resource.provider }
    end
  end
end
