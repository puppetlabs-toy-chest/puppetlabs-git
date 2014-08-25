Puppet::Type.newtype(:git_config) do

  newparam(:name) do
    desc "The default namevar"
  end

  newproperty(:value) do
    desc "The config value. Example Mike Color or john.doe@example.com"
    newvalues(/.+/)
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
        /^([^\.]+)\.([^\.]+)$/,
        [
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
