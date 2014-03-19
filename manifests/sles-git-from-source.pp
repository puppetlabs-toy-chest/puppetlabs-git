class git::sles-git-from-source (
  $tmp_dir = '/tmp',
  $git_sha1 = 'e60667fc16e5a5f1cde46616b0458cc802707743',
  $git_md5 = undef,
  $git_filename = "${git_dirname}.tar.gz",
  $git_dirname = 'git-1.9.0',
  $git_website = 'http://git-core.googlecode.com/files',
  $zlib_md5 = '44d667c142d7cda120332623eab69f40',
  $zlib_sha1 = undef,
  $zlib_filename = "${zlib_dirname}.tar.gz",
  $zlib_dirname = 'zlib-1.2.8',
  $zlib_website = 'http://downloads.sourceforge.net/project/libpng/zlib/1.2.8',
){

  package { ['openssl', 'wget', 'make', 'autoconf', 'gcc', 'zlib', 'gettext-runtime']:
    ensure => 'installed',
  }

  define wget_and_check ($website, $filename, $sha1 = undef, $md5 = undef) {
    exec { "wget -c ${website}/${filename}":
      command => "wget -c ${website}/${filename}",
      creates => "${tmp_dir}/$filename",
      cwd => $tmp_dir,
      provider => 'shell',
      require => Package['wget'],
      returns => '0',
    }

    if $sha1 != undef {
      exec { "check ${filename} sha1 checksum":
        command => "[[ $(openssl sha1 ${tmp_dir}/${filename} | cut -d ' ' -f 2) == ${sha1} ]]",
        provider => 'shell',
        returns => '0',
        require => [ Exec["wget -c ${website}/${filename}"] ,Package['openssl'] ],
      }
    } elsif $md5 != undef {
      exec { "check ${filename} md5 checksum":
        command => "[[ $(openssl md5 ${tmp_dir}/${filename} | cut -d ' ' -f 2) == ${md5} ]]",
        provider => 'shell',
        returns => '0',
        require => [ Exec["wget -c ${website}/${filename}"] ,Package['openssl'] ],
      }
    }
  }

  wget_and_check { 'git':
    website => $git_website,
    filename => $git_filename,
    sha1 => $git_sha1,
  }

  wget_and_check { 'zlib':
    website => $zlib_website,
    filename => $zlib_filename,
    md5 => $zlib_md5,
  }

  exec { 'install zlib':
    command => "cd ${tmp_dir} && tar xzf ${zlib_filename} && cd ${zlib_dirname} && ./configure && make && make install",
    provider => 'shell',
    require => [ Wget_and_check[ 'git', 'zlib' ], Package['make', 'autoconf', 'gcc', 'zlib', 'gettext-runtime']],
  }

  exec { 'install git':
    command => "cd ${tmp_dir} && tar xzf ${git_filename} && cd ${git_dirname} && ./configure --prefix=/usr && make all && make install",
    provider => 'shell',
    require => Exec['install zlib'],
  }
}
