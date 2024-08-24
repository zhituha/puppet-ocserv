class ocserv::service (
  String[1]                       $service_name  = 'ocserv',
  Enum[ 'running', 'stopped' ]    $ensure        = 'running',
  Enum[ 'true', 'false', 'manual',
        'mask', 'delayed' ]       $enable        = 'true',
  Boolean                         $hasrestart    = true,
  String[1]                       $bin_name      = 'ocserv',  # CHECKME
  Boolean                         $use_systemd   = true,
  String[1]                       $provider      = if $use_systemd { 'systemd' } else { 'upstart' },  # CHECKME 
#  String[1]                       $
  String[1]                       $kill_bin_path = '/usr/bin/kill',
  Optional[String[1]]             $pid_file      = undef,
) {

  #TODO test config before restart
  if $use_systemd {
    $reload_command  = "systemctl reload ${service_name}"
    $restart_command = "systemctl restart ${service_name}"
  } else {
    $reload_command  = "service ${service_name} reload"
    $restart_command = "service ${service_name} restart"
  }

  service { "${service_name}":
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => $hasrestart,
    provider   => $provider,
  }

  exec {"Restart ocserv":
    command   => $restart_command,
    provider  => shell,
    alias     => 'ocserv-restart',
    refreshonly => true,
  }

  exec {"Reload ocserv":
    command   => $reload_command,
    provider  => shell,
    alias     => 'ocserv-reload',
    refreshonly => true,
  }
}
