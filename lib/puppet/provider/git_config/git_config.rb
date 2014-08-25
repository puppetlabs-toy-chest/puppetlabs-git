Puppet::Type.type(:git_config).provide(:git_config) do

  mk_resource_methods

  def create
    require 'etc'
    home = Etc.getpwnam(@resource[:user]).dir
    Puppet::Util::Execution.execute("git config --global #{@resource[:section]}.#{@resource[:key]} '#{@resource[:value]}'",
                                    :uid => @resource[:user],
                                    :failonfail => true,
                                    :custom_environment => { 'HOME' => home },
                                   )
  end
end
