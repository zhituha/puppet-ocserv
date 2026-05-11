# @summary
#   Main class for OpenConnect Server (ocserv).
#
#   Installs, configures and manages the ocserv VPN server.
#
# @param ensure
#   Controls the state of the ocserv installation.
#   Valid values: `present`, `absent`, `purged`, `installed`, `latest`.
#
# @param package_name
#   Name of the ocserv package.
#
# @param package_version
#   Specific version of the package to install. `undef` means use the default.
#
# @param runas_user
#   System user that ocserv will run as.
#
# @param runas_group
#   System group that ocserv will run as.
#
# @param base_conf_dir
#   Base directory for ocserv configuration files.
#
# @param per_user_conf_dir
#   Directory for per-user configuration files.
#
# @param per_group_conf_dir
#   Directory for per-group configuration files.
#
# @param configure_logrotate
#   Whether to manage logrotate configuration for ocserv.
#
# @param log_dir
#   Directory where logs are stored.
#
# @param log_file
#   Main log file name.
#
# @example
#   class { 'ocserv':
#     tcp_port     => 443,
#     ipv4_network => '10.10.10.0/24',
#   }

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
