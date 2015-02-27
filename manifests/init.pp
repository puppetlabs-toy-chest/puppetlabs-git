# Class: git
#
# This class installs git
#
# Actions:
#   - Install the git package
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
class git (
  $package_name   = 'git',
  $package_ensure = 'installed',
  $package_manage = true,
) {
  if ( $package_manage ) {
    package { $package_name:
      ensure => $package_ensure,
    }
  }
}
