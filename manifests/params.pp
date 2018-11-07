# Git::params
#
#
class git::params {
  $package_ensure = 'installed'
  $package_manage = true

  if $::osfamily == 'Suse' {
    $package_name   = 'git-core'
  } else {
    $package_name   = 'git'
  }
}