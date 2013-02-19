# Class: dome9::package
#
# This module manages Dome9 package installation
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class dome9::package (
  $pairkey = undef
) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  if ($pairkey == undef) {
    fail('You must specify a pairkey')
  }

  exec { 'dome9-key.asc':
    command => 'wget -O - http://repository.dome9.com/ubuntu/dome9-key.asc | apt-key add -',
    unless  => 'apt-key list | grep -c dome9-key.asc',
  }

  exec { 'dome9.list':
    command => "echo 'deb http://repository.dome9.com/ubuntu lucid main' >> /etc/apt/sources.list.d/dome9.list && apt-get update",
    creates => '/etc/apt/sources.list.d/dome9.list',
    require => Exec['dome9-key.asc']
  }

  package { 'dome9agent':
    ensure  => latest,
    require => Exec['dome9.list'],
    notify  => Exec['pairkey']
  }

  exec { 'pairkey':
    command     => "dome9d pair -k ${pairkey}",
    refreshonly => true
  }
}