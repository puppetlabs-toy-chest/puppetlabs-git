Puppet::Type.type(:git_config).provide(:git_config) do

  mk_resource_methods

  def value
    require 'etc'
    user    = @property_hash[:user]    = @resource[:user]
    key     = @property_hash[:key]     = @resource[:key]
    section = @property_hash[:section] = @resource[:section]
    home    = Etc.getpwnam(user)[:dir]

    current = Puppet::Util::Execution.execute(
      "git config --global --get #{section}.#{key}",
      :uid => user,
      :failonfail => false,
      :custom_environment => { 'HOME' => home }
    )
    @property_hash[:value] = current.strip
    @property_hash[:value]
  end

  def value=(value)
    require 'etc'
    user    = @resource[:user]
    key     = @resource[:key]
    section = @resource[:section]
    home    = Etc.getpwnam(user)[:dir]

    Puppet::Util::Execution.execute(
      "git config --global #{section}.#{key} '#{value}'",
      :uid => user,
      :failonfail => true,
      :custom_environment => { 'HOME' => home }
    )
  end

end
