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

$package_name = $operatingsystem ? {
  debian  => 'git',
  default => 'git-core',
}

class git {
  package { $package_name:
    ensure => installed,
  }
}
