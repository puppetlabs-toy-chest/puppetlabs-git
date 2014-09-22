Puppet::Type.type(:git_config).provide(:git_config) do

  mk_resource_methods

  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def user=(value)
    @property_flush[:user] = value
  end

  def key=(value)
    @property_flush[:key] = value
  end

  def key=(value)
    @property_flush[:key] = value
  end

  def value=(value)
    @property_flush[:value] = value
  end

  def flush
    require 'etc'
    user    = @resource[:user]
    key     = @resource[:key]
    section = @resource[:section]
    value   = @resource[:value]
    home    = Etc.getpwnam(user)[:dir]

    current = Puppet::Util::Execution.execute(
      "git config --global --get #{section}.#{key} '#{value}'",
        :uid => user,
        :failonfail => false,
        :custom_environment => { 'HOME' => home }
       )
    unless value == current.strip then
      Puppet::Util::Execution.execute(
        "git config --global #{section}.#{key} '#{value}'",
            :uid => user,
            :failonfail => true,
            :custom_environment => { 'HOME' => home }
           )
    end
    @property_hash = @resource.to_hash
  end

end
