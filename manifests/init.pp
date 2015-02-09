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
class git ($package_name = 'git') {
  if(!defined(Package[$package_name])) {
    package { $package_name:
      ensure => present,
    }
  }
}
