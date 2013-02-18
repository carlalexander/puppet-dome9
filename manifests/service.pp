# Class: dome9::service
#
# This module manages the Dome9 daemon service
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
class dome9::service {
  service { "dome9d":
    ensure     => running,
    enable     => true,
    hasstatus  => false,
  }
}