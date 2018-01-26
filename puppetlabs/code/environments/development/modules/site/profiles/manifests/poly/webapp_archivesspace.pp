# == Class: profile::webapp_archivesspace
#
# Full description of class profile here.
#
# === Authors
#
# Flannon flannon@nyu.edu
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class profiles::poly::webapp_archivesspace (
  #$install_dir = lookup('archivesspace::install_dir', String, 'first' ),
  #$db_host     = lookup('archivesspace::db_host', String, 'first' ),
  #$db_name     = lookup('archivesspace::db_name', String, 'first' ),
  #$db_passwd   = lookup('archivesspace::db_passwd', String, 'first' ),
  #$db_user     = lookup('archivesspace::db_user', String, 'first' ),
  #$ensure             = lookup('archivesspace::ensure', String, 'first'),
  #$plugin_install_dir = lookup('archivesspace::plugin_install_dir', String, 'first'),
  #
  #$plugin_ead_export_revision = lookup('archivesspace::plugin_ead_export_revision'), 
  #$plugin_marcxml_export_revision = lookup('archivesspace::plugin_marcxml_export_revision'),
  #$plugin_sso_revision = lookup('archivesspace::plugin_sso_revision'),
  #$user                = lookup('archivesspace::user', String, 'first' ),
  #$group               = lookup('archivesspace::group', String, 'first' ),
  ##$region             = chop($ec2_placement_availability_zone),
  $ensure = lookup('archivesspace::ensure', String, 'first'),
  $version        = lookup('profiles::poly::version', String, 'first'),
  $install_dir    = lookup('profiles::poly::install_dir', String, 'first'),
  $conf_dir       = lookup('profiles::poly::conf_dir', String, 'first'),
  $conf_file      = lookup('profiles::poly::conf_file', String, 'first'),
  $java_heap_max  = lookup('profiles::poly::java_heap_max', String, 'first'),
  $log_level      = lookup('profiles::poly::log_level', String, 'first'),
  $enable_backend = lookup('profiles::poly::enable_backend', String, 'first'),
  $enable_frontend = lookup('profiles::poly::enable_frontend', String, 'first'),
  $enable_public   = lookup('profiles::poly::enable_public', String, 'first'),
  $enable_solr     = lookup('profiles::poly::enable_solr', String, 'first'),
  $enable_indexer  = lookup('profiles::poly::enable_indexer', String, 'first'),
  $enable_docs     = lookup('profiles::poly::enable_docs', String, 'first'),
  $enable_oai      = lookup('profiles::poly::enable_oai', String, 'first'),
  $fsdb            = lookup('profiles::poly::fsdb', String, 'first'),
  $user            = lookup('profiles::poly::user', String, 'first'),
  $group           = lookup('profiles::poly::group', String, 'first'),
  $db_passwd       = lookup('profiles::poly::db_passwd', String, 'first'),
  $db_name         = lookup('profiles::poly::db_name', String, 'first'),
  $db_user         = lookup('profiles::poly::db_user', String, 'first'),
  $db_host         = lookup('profiles::poly::db_host', String, 'first'),
  $plugin          = lookup('profiles::poly::plugin', String, 'first'),
  $plugin_conf     = lookup('profiles::poly::plugin_conf', String, 'first'),
  $plugin_install_dir = lookup('profiles::poly::plugin_install_dir', String, 'first'),
  $plugin_ensure   = lookup('profles::poly::plugin_ensure', String, 'first'),
  $plugin_prefix   = lookup('profiles::poly::plugin_prefix', String, 'first'),
  $plugin_revision = lookup('profiles::poly::plugin_revision', String, 'first'),
  $plugin_source   = lookup('profiles::poly::plugin_source', String, 'first'),
  $plugin_marcxml_export_revision = lookup('profiles::poly::plugin_marcxml_export_revision', String, 'first'),
  $plugin_ead_export_revision     = lookup('profiles::poly::plugin_ead_export_revision', String, 'first'),
  $plugin_sso_revision            = lookup('profiles::poly::plugin_sso_revision', String, 'first'),
) {

  #warning("this is the region: ${region}")

  # Add default group and users
  group { 'dlib' :
    ensure => present,
    gid    => '200',
  }
  #accounts::account { 'esha' : }
  #accounts::account { 'don' : }
  #accounts::account { 'flannon' : }
  #accounts::account { 'joe' : }
  #accounts::account { 'ekate' : }

  # Addd dlib group to sudoers
  file_line { 'sudo_rule_nopw':
    path => '/etc/sudoers',
    line => '%dlib    ALL=(ALL)   NOPASSWD: ALL',
  }

  if ($facts['os']['family'] == 'RedHat') and ($facts['os']['release']['major'] == '6') {
    include dltsyumrepo::development
  }
  elsif ($facts['os']['family'] == 'RedHat') and ($facts['os']['release']['major'] == '7') {
     include dltsyumrepo::el7::test
  }

  #include dltsyumrepo::dlts

  ## Load hiera
  #include hiera
  ## Load the hieradata
  #hiera::hieradata { 'aspace-prod' : }
  #hiera::gitmodules { 'aspace-prod' : }

  #include puppetcron
  class { 'java':
    package => 'java-1.8.0-openjdk',
  }
  #include housekeeping::nfs

  # mount efs volumes
  #file { "${install_dir}/data" :
  #  ensure => directory,
  #  owner  => $user,
  #  group  => $user,
  #  mode   => '0755',
  #}

  
  include profiles::db_mysql
  include archivesspace::database
  #include archivesspace
  alert("Version: $version")
  notice("Version: $version")
  alert("Version: $version")
  notice("Version: $version")
  alert("Version: $version")
  class  { archivesspace: 
    ensure                         => $ensure, 
    version                        => $version,
    install_dir                    => $install_dir,
    conf_dir                       => $conf_dir,
    conf_file                      => $conf_file,
    java_heap_max                  => $java_heap_max,
    log_level                      => $log_level,
    enable_backend                 => $enable_backend,
    enable_frontend                => $enable_frontend,
    enable_public                  => $enable_public,
    enable_solr                    => $enable_solr,
    enable_indexer                 => $enable_indexer,
    enable_docs                    => $enable_docs, 
    enable_oai                     => $enable_oai,
    fsdb                           => $fsdb,
    user                           => $user,
    group                          => $group,
    db_passwd                      => $db_passwd,
    db_name                        => $db_name,
    db_user                        => $db_user,
    db_host                        => $db_host,
    plugin                         => $plugin,
    plugin_conf                    => $plugin_conf,
    plugin_install_dir             => $plugin_install_dir,
    plugin_ensure                  => $plugin_ensure,
    plugin_prefix                  => $plugin_prefix,
    plugin_revision                => $plugin_revision,
    plugin_source                  => $plugin_source,
    #plugin_marcxml_export_revision => $plugin_marcxml_export_revision,
    #plugin_ead_export_revision     => $plugin_ead_export_revision,
    #plugin_sso_revision            => $plugin_sso_revision, 
  }

  #  require => Efsmount::Mount_volume['/opt/archivesspace/data/solr_backups'],
  #}

  ##
  #  Make sure the solr_home directory tree exists
  #    -- Should this actually be in the modules install class? Yes
  ##
  #$solr_home = [ "${install_dir}/data/solr_home",
  #              "${install_dir}/data/solr_home/collection1",
  #              "${install_dir}/data/solr_home/collection1/conf",
  #            ]
  #
  #file { $solr_home:
  #  ensure  => 'directory',
  #  owner   => $user,
  #  group   => $user,
  #  mode    => '0700',
  #  #require => Class['archivesspace::install'],
  #  #notify  => Archivesspace::Plugin['nyu_marcxml_export_plugin'],
  #}

  ##
  #  Load plugins
  ##
  #archivesspace::plugin { 'nyu_marcxml_export_plugin' :
  #  ensure          => 'present',
  #  plugin          => 'nyu_marcxml_export_plugin',
  #  plugin_source   => 'https://github.com/NYULibraries/nyu_marcxml_export_plugin.git',
  #  plugin_conf     => 'AppConfig[:plugins] = [\'nyu_marcxml_export_plugin\', \'nyu_ead_export_plugin\', \'nyu_sso_plugin\', \'digitization_work_order\']',
  #  #plugin_revision => $plugin_marcxml_export_revision,
  #  plugin_revision => 'production',
  #  require         => Class['archivesspace::install'],
  #}
  #archivesspace::plugin { 'nyu_ead_export_plugin' :
  #  ensure          => 'present',
  #  plugin          => 'nyu_ead_export_plugin',
  #  plugin_source   => 'https://github.com/NYULibraries/nyu_ead_export_plugin.git',
  #  plugin_conf     => 'AppConfig[:plugins] = [\'nyu_marcxml_export_plugin\', \'nyu_ead_export_plugin\', \'nyu_sso_plugin\', \'digitization_work_order\']',
  #  plugin_revision => $plugin_ead_export_revision,
  #  require         => Class['archivesspace::install'],
  #}
  #archivesspace::plugin { 'hudmol_digitization_work_order' :
  #  ensure          => 'present',
  #  plugin          => 'digitization_work_order',
  #  plugin_source   => 'https://github.com/hudmol/digitization_work_order.git',
  #  plugin_conf     => 'AppConfig[:plugins] = [\'nyu_marcxml_export_plugin\', \'nyu_ead_export_plugin\', \'nyu_sso_plugin\', \'digitization_work_order\']',
  #  plugin_revision => 'master',
  #  require         => Class['archivesspace::install'],
  #}
  #archivesspace::plugin { 'nyu_sso_plugin' :
  #  ensure          => present,
  #  plugin          => 'nyu_sso_plugin',
  #  plugin_source   => 'https://github.com/NYULibraries/nyu_sso_plugin.git',
  #  plugin_conf     => 'AppConfig[:plugins] = [\'nyu_marcxml_export_plugin\', \'nyu_ead_export_plugin\', \'nyu_sso_plugin\', \'digitization_work_order\']',
  #  plugin_revision => $plugin_sso_revision,
  #  require         => Class['archivesspace::install'],
  #}
  #exec { 'initialize-plugin.sh nyu_sso_plugin' :
  #  cwd     => "${install_dir}/plugins/nyu_sso_plugin",
  #  command => "${install_dir}/scripts/initialize-plugin.sh nyu_sso_plugin",
  #  timeout => 2600,
  #  creates => "${install_dir}/plugins/.initialize-nyu_sso_plugin-complete",
  #  require => Archivesspace::Plugin['nyu_sso_plugin'],
  #  notify  => File["${install_dir}/plugins/nyu_sso_plugin/.initialize-nyu_sso_plugin-complete"],
  #}->
  #class { 'archivesspace::service' : }
  #file { "${install_dir}/plugins/nyu_sso_plugin/.initialize-nyu_sso_plugin-complete" :
  #  ensure  => present,
  #  content => 'nyu_sso_plugin gems installed.',
  #  owner   => $user,
  #  group   => $group,
  #}
  firewall { '100 allow http and https access':
    dport  => [ 80, 8080, 8081, 8082, 8089, 8090, 8091 ],
    proto  => tcp,
    action => accept,
  }
  #firewall { '102 forward port 80 to 8080':
  #  table   => 'nat',
  #  chain   => 'PREROUTING',
  #  iniface => 'eth0',
  #  proto   => 'tcp',
  #  dport   => '80',
  #  jump    => 'REDIRECT',
  #  toports => 8080,
  #}

  # set up the db
  #include profiles::db_mysql
  #mysql::db { 'asdb' :
  #  user     => $db_user,
  #  password => $db_passwd,
  #  dbname   => $db_name,
  #  host     => 'localhost',
  #  grant    => [ 'ALL' ],
  #  #notify   => Class['archivesspace'],
  #}
  include mysql::client
  include mysql::bindings
  include pyenv
}
