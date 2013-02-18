# Class: dome9
#
# This module manages Dome9.
#
# Parameters:
#
#   [*pairkey*] - Pairkey to use
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include dome9
# }
class dome9 (
  $pairkey = undef
) {
  class { 'dome9::package':
    notify => Class['dome9::service'],
  }

  class { 'dome9::config':
    pairkey => $pairkey,
    require => Class['dome9::package'],
    notify  => Class['dome9::service'],
  }
  class { 'dome9::service': }
}