Puppet::Type.type(:git_config).provide(:git_config) do

  mk_resource_methods

  def initialize(value={})
    super(value)
  end

  def create
    require 'etc'
    user    = @resource[:user]
    key     = @resource[:key]
    section = @resource[:section]
    value   = @resource[:value]
    home    = Etc.getpwnam(user)

    unless Puppet::Util::Execution.execute(
      "git config --global --get #{section}.#{key} '#{value}'",
        :uid => user,
        :failonfail => true,
        :custom_environment => { 'HOME' => home }
       ) then
      Puppet::Util::Execution.execute(
        "git config --global #{section}.#{key} '#{value}'",
            :uid => user,
            :failonfail => true,
            :custom_environment => { 'HOME' => home }
           )
    end
  end

end
