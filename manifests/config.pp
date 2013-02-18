# Class: dome9::config
#
# This module manages Dome9 bootstrap and configuration
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
class dome9::config(
  $pairkey = undef
)  {
  if ($pairkey == undef) {
    fail('You must specify a pairkey')
  }

  exec { 'add pairkey':
    command => "dome9d pair -k $pairkey",
    notify  => Class['dome9::service']
  }
}