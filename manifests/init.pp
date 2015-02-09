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
  ensure_packages([ $package_name ])
}
