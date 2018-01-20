## vagrant-archivesspace
Vagrant installer for archivesspace

#### Table of Contents

1.  [Overview] (#overview)
3.  [Installation] (#installation)
5.  [Usage] (#usage)
5.  [Storage] (#storage)


#### Overview

Installs archivesspace on a vagrant box running Cnetos 7.


#### Installation

To get Archivesspace running download the vagrant file and run 'vagrant up'.

    $ git clone https://github.com/NYULibraries/vagrant-archivesspace
    $ cd vagrant-archivesspace
    $ vagrant up


### Usage

Vagrant-archivesspace will install the latest version of Archivesspace 
on a Virtualbox VM running Centos 7 and mysql.  

To connect to your vagrant box you can,

    $ vagrant ssh

 To connect to the front end point your browser at 

    http://localhost:8080 

 Archivesspace has the default username and password, admin/admin

The archivesspace ports have been mapped in the following way,

> frontend   8080 => localhost:8080

> public     8081 => localhost:8081

> backend    8089 => localhost:8089

> solr       8090 => localhost:8090

> indexer    8091 => localhost:8091


Archivesspace is installed in /opt/archivesspace.  

Archivesspace uses the following  mysql settings,

  user:     asdb
  password: password

The shared directory is mapped from /vagrant on the guest to the current dirrectory.

Once vagrant is ready it'll still take archivesspace a few minutes to finish.    For the impatient you can watch the logs while you wait,

    vagrant ssh
    tail -f /opt/archivesspace/logs/archivesspace.out

Port 8080 on the guest is mapped to port 9080 on the host, just because 8080 always seems to be taken.  For your convenience has a second interface with the ip address 192.168.50.39, so you can see all of the interfaces on their normal ports.

    http://192.168.50.39:8080


#### Storage

The vagrantfile will mount a second volume on /var/lib/mysql in the guest, and the .vdi file that maps to the volume will be in ./unstracked-files in the directory with the Vagrantfile on the host.  The default value for the second volume is 10GB.  IF you would like to change the volume size you'll need to edit the Vagrantfile before running `vagrant up`, and change the following line,

    config.persistent_storage.size = 10240

The size of the volume is calculated in MBs.
