#
class housekeeping::params {

  case $facts['os']['family'] {
    'RedHat': {
      case $facts['os']['release']['major'] {
        '7': {
          case $facts['virtual'] {
            'xenu':       { $user = 'centos' }
            'xenhvm':     { $user = 'centos' }
            'virtualbox': { $user = 'vagrant' }
            default:  {
              fail("Virtualization platform ${facts['virtual']} is not supported at this time")
            }
          } # End case 3
        }
        '6': {
          case $facts['virtual'] {
            'xenu':       { $user = 'ec2-user' }
            'xenhvm':     { $user = 'ec2-user' }
            'virtualbox': { $user = 'vagrant' }
            default:  {
              fail("Virtualization platform ${facts['virtual']} is not supported at this time")
            }
          } # End case 3
        }
        default: {
          fail( "${facts['os']} ${facts['os']['release']['major']} is not supported at this time" )
        }
      } # End case 2
    }
    default: {
      fail( "${facts['os']} ${facts['os']['release']['major']} is not supported at this time" )
    }
  } # End case
}
