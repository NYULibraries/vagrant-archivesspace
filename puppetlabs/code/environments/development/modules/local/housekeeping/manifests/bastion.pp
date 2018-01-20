class housekeeping::bastion {

  ensure_packages([
    'epel-release',
    'lsof',
    'ncurses-devel',
    'openssl-devel',
    'zlib-devel',
  ])

  if ($facts['os']['family'] == 'RedHat') and ($facts['os']['release']['majo    r'] == '7') {
    ensure_packages([
      'gdbm-devel',
    ])
  }

}

