class git::params() {
  case $::osfamily {
    'redhat','debian': { $package = 'git' }
    'suse': { $package = 'git-core' }
    default: {fail("OS family ${::osfamily} not supported!")}
  }
}
