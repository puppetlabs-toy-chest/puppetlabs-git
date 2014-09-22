Puppet::Type.type(:git_config).provide(:git_config) do

  mk_resource_methods

  def check_current?(value)
    require 'etc'
    user    = @resource[:user]
    key     = @resource[:key]
    section = @resource[:section]
    home    = Etc.getpwnam(user)[:dir]

    current = Puppet::Util::Execution.execute(
      "git config --global --get #{section}.#{key}",
      :uid => user,
      :failonfail => false,
      :custom_environment => { 'HOME' => home }
    )
    return value == current.strip
  end

  def update
    require 'etc'
    user    = @resource[:user]
    key     = @resource[:key]
    section = @resource[:section]
    value   = @resource[:value]
    home    = Etc.getpwnam(user)[:dir]

    Puppet::Util::Execution.execute(
      "git config --global #{section}.#{key} '#{value}'",
      :uid => user,
      :failonfail => true,
      :custom_environment => { 'HOME' => home }
    )
  end

end
