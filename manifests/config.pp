define git::config(
  $value,
  $section  = regsubst($name, '^([^\.]+)\.([^\.]+)$','\1'),
  $key      = regsubst($name, '^([^\.]+)\.([^\.]+)$','\2'),
) {
  exec{"git config --global ${section}.${key} '${value}'":
    environment => inline_template('<%= "HOME=" + ENV["HOME"] %>'),
    path        => ['/usr/bin', '/bin', '/usr/local/bin',],
    unless      => "git config --global --get ${section}.${key} '${value}'",
  }
}
