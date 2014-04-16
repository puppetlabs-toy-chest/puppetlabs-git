class git::repo (
  $ensure      = present,
  $include_src = false,
) {
  case $::osfamily {
    'Debian': {
      $key         = 'E1DF1F24'
      $location    = 'http://ppa.launchpad.net/git-core/ppa/ubuntu'
      $source_name = 'git-core'
      class { 'git::repo::debian': }
    }
    default: {
      fail("Unsupported managed repository for osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports managing repos for osfamily Debian and Ubuntu")
    }
  }
}
