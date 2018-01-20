#
define golang::env {

  $user = $title

  if $title == 'root' {
    $userhome = "/${title}"
  }
  else {
    $userhome = "/home/$title"
  }

  file_line { "${userhome} goroot":
    path => "${userhome}/.bashrc",
    #line => 'export GOROOT=/usr/lib/golang',
    line => 'export GOROOT=/opt/go',
  }
  file_line { "${userhome} gopath":
    path => "${userhome}/.bashrc",
    line => "export GOPATH=${userhome}/go",
  }
  file_line { "${userhome} gobin":
    path => "${userhome}/.bashrc",
    line => "export GOBIN=${userhome}/go/bin",
  }
  file_line { "${userhome} userpath":
    path => "${userhome}/.bashrc",
    line => 'export PATH=$GOPATH/bin:%GOROOT/bin:$PATH',
  }
  $godirs = [
              "${userhome}/go", 
              "${userhome}/go/bin", 
              "${userhome}/go/pkg", 
              "${userhome}/go/src", 
              "${userhome}/go/projects", 
            ]
  file { $godirs :
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => '0755',
  }
}
