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

  case $::operatingsystem {
    /(?ix:sles)/: {
      include git::sles-git-from-source
    }
    default : {
      package { 'git':
        ensure => installed,
      }
    }
  }
}
