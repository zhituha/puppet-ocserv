class ocserv (

  # package
  Enum[present, absent, purged, installed, latest]
  $ensure                                            = present,
  String[1]           $package_name                  = 'ocserv',
  Optional[String]    $package_version               = undef,

  # base config
  String[1]           $runas_user                    = 'ocserv',
  String[1]           $runas_group                   = 'ocserv',

  String[1]           $base_conf_dir                 = '/etc/ocserv',
  String[1]           $per_user_conf_dir             = "${base_conf_dir}/config-per-user",
  String[1]           $per_group_conf_dir            = "${base_conf_dir}/config-per-group",



  # system changes
  Boolean             $configure_logrotate           = false,
  String[1]           $log_dir                       = '/var/log',
  Optional[String[1]] $log_file                      = 'ocserv.log',

) {


  if $ensure in [ present, installed, latest ] {

    contain ocserv::install
    contain ocserv::config
    contain ocserv::service

    Class['ocserv::install'] -> Class['ocserv::config']
    #Class['ocserv::config'] ~> Class['ocserv::service']

  } else {

    contain ocserv::remove

  }

  if $configure_logrotate {

    contain ocserv::logrotate

  }
}

