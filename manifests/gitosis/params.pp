class gitosis::params() {
  case $::osfamily {
    'redhat': { $package = 'gitosis' }
    default: {fail("OS family ${::osfamily} not supported!")}
  }
}
