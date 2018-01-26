# == Class: role::archivesspace
#
# Full description of class role here.
#
# === Authors
#
# Flannon Jackson <flannon@nyu.edu>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class roles::aspace_poly {

    include profiles::base
    include profiles::db_mysql
    include profiles::poly::webapp_archivesspace

}
