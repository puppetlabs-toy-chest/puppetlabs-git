# == Define: git::config
#
# Used to configure git
#
# === Parameters
#
# [*value*]
#   The config value. Example: Mike Color or john.doe@example.com.
#   See examples below.
#
# [*section*]
#   The configuration section. Example: user.
#   By default extracted from the resource name.
#
# [*key*]
#   The configuration key. Example: email.
#   By default extracted from the resource name.
#
# [*user*]
#   The user for which the config will be set. Default value: root
#
# === Examples
#
# Provide some examples on how to use this type:
#
#   git::config { 'user.name':
#     value => 'John Doe',
#   }
#
#   git::config { 'user.email':
#     value => 'john.doe@example.com',
#   }
#
#   git::config { 'user.name':
#     value   => 'Mike Color',
#     user    => 'vagrant',
#     require => Class['git'],
#   }
#
# === Authors
#
# === Copyright
#
define git::config(
  $value,
  $section  = regsubst($name, '^([^\.]+)\.([^\.]+)$','\1'),
  $key      = regsubst($name, '^([^\.]+)\.([^\.]+)$','\2'),
  $user     = 'root',
) {
  if $user == 'root' {
    # If the command should be executed as root

    exec{"git config --global ${section}.${key} '${value}'":
      environment => inline_template('<%= "HOME=" + ENV["HOME"] %>'),
      path        => ['/usr/bin', '/bin'],
      unless      => "git config --global --get ${section}.${key} '${value}'",
    }

  } else {
    # If the command should be executed as non root user
    #
    # The .giconfig will be created in /home/$user

    exec{"su - ${user} -c \"git config --global ${section}.${key} '${value}'\"":
      environment => inline_template('<%= "HOME=" + ENV["HOME"] %>'),
      path        => ['/usr/bin', '/bin'],
      unless      => "su - ${user} -c \"git config --global --get ${section}.${key} '${value}'\"",
    }

  }
}