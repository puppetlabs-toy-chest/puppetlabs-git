# Class: gitosis
#
# This installs and configures gitosis 
#
# Requires:
#  - Class[git]
#
class git::gitosis inherits gitosis::params {
  include ::git
  package { $package: ensure => present }
}
