# Class: git
#
# This class installs and configures git
#
# Actions:
#   - Install the git package
#   - Configure git
#
# Sample Usage:
#  class { 'git': }
#
# === Parameters
#
# [*package_ensure*]
#   Value to be passed to ensure in the package resource. Defaults to installed.
#
# [*package_manage*]
#   boolean toggle to overide the management of the git package.
#   You may want to change this behavior if another module manages git packages
#   defaults to true
#
# [*configs*]
#   hash of configurations as per the git::config defined type
#
class git (
  $package_name   = 'git',
  $package_ensure = 'installed',
  $package_manage = true,
  $configs = {}
) {
  if ( $package_manage ) {
    package { $package_name:
      ensure => $package_ensure,
    }
  }
  
  create_resources(git::config, $configs)
}
