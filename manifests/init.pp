# main class.
# @param ensure Whether install and configure an openconnect server or not.
# @param package_name Package name to install. Default: 'ocserv'
# @param package_version Version of the package to install. Default: $ensure.
# @param user Name of a user running an ocserv instance. Default: 'ocserv'
# @param group Group for ocserv-related files. Default: 'ocserv'
# @param base_conf_dir Directory for configuration files. Default: '/etc/ocserv'
# @param per_user_conf_dir Path for per-user configuration files. Default: the 'config-per-user' under the $base_conf_dir.
# @param per_group_conf_dir Path for per-group configuration files. Default: the 'config-per-group' under the $base_conf_dir.
# @param configure_logrotate Either configure logrotate for the ocserv or not.

class ocserv (

  Enum[present, absent] $ensure                      = present,
  
  # package
  String[1]           $package_name                  = 'ocserv',
  Optional[String]    $package_version               = undef,

  # base config
  String[1]           $user                          = 'ocserv',
  String[1]           $group                         = 'ocserv',

  String[1]           $base_conf_dir                 = '/etc/ocserv',
  String[1]           $per_user_conf_dir             = "${base_conf_dir}/config-per-user",
  String[1]           $per_group_conf_dir            = "${base_conf_dir}/config-per-group",

  Boolean             $configure_logrotate           = false,

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

