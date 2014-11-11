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
   
   git_config { 'http.sslCAInfo':
     value   => $companyCAroot,
     user    => 'root',
     scope   => 'system',
     require => Company::Certificate['companyCAroot'],
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

  newparam(:user) do
    desc "The user for which the config will be set. Default value: root"
    defaultto "root"
  end

  newparam(:section, :namevar => true) do
    desc "The configuration section. Example: user."
  end

  newparam(:key, :namevar => true) do
    desc "The configuration key. Example: email."
  end

  newparam(:scope) do
    desc "The scope of the configuration, can be system or global. Default value: global"
    defaultto "global"
  end

  # taken from augeasproviders
  def self.title_patterns
    [
      [
        /^(([^\.]+)\.([^\.]+))$/,
        [
          [ :name ],
          [ :section ],
          [ :key ],
        ]
      ],
      [
        /(.*)/,
        [
          [ :name ],
        ]
      ]
    ]
  end

end
