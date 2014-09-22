Puppet::Type.newtype(:git_config) do

  desc <<-DOC
  Used to configure git
  === Examples


   git_config { 'user.name':
     value => 'John Doe',
   }

   git_config { 'user.email':
     value => 'john.doe@example.com',
   }

   git_config { 'user.name':
     value   => 'Mike Color',
     user    => 'vagrant',
     require => Class['git'],
   }
  DOC

  validate do
    fail('it is required to pass "value"') if self[:value].nil? || self[:value].empty? || self[:value] == :absent
  end

  newparam(:name) do
    desc "The default namevar"
  end

  newproperty(:value) do
    desc "The config value. Example Mike Color or john.doe@example.com"
  end

  newproperty(:user) do
    desc "The user for which the config will be set. Default value: root"
    defaultto "root"
  end

  newproperty(:section, :namevar => true) do
    desc "The configuration section. Example: user."
  end

  newproperty(:key, :namevar => true) do
    desc "The configuration key. Example: email."
  end

  # taken from augeasproviders
  def self.title_patterns
    identity = lambda { |x| x }
    [
      [
        /^(([^\.]+)\.([^\.]+))$/,
        [
          [ :name, identity ],
          [ :section, identity ],
          [ :key, identity ],
        ]
      ],
      [
        /(.*)/,
        [
          [ :name, identity ],
        ]
      ]
    ]
  end

end
