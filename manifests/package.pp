# Class: dome9::package
#
# This module manages OpenSSH Server package installation
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
class dome9::package {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  exec { 'dome9.list':
    command => "/bin/echo 'deb http://repository.dome9.com/ubuntu lucid main' >> /etc/apt/sources.list.d/dome9.list",
    creates => '/etc/apt/sources.list.d/dome9.list'
  }

  exec { 'dome9-key.asc':
    command => '/usr/bin/wget -O - http://repository.dome9.com/ubuntu/dome9-key.asc | /usr/bin/apt-key add -',
    unless  => '/usr/bin/apt-key list | /bin/grep -c dome9-key.asc',
  }

  package { 'dome9agent':
    ensure  => latest,
    require => [Exec['dome9-key.asc'], Exec['dome9.list']]
  }
}