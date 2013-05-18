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
class git {

  $gitpkg = $::osfamily ? {
    'RedHat' => 'git',
    'Debian' => 'git-core',
  }

  package { $gitpkg:
    ensure => installed,
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
