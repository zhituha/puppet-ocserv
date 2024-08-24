class ocserv::logrotate (

  String[1]           $logrotate_dir   = '/etc/logrotate.d/',
  String[1]           $logrotate_conf  = 'ocserv.conf',
  String[1]           $log_dir         = '/var/log',
  Optional[String[1]] $log_file        = 'ocserv.log',
  Integer             $logs_count      = 7,
  Enum[ 
    'hourly', 'daily',
    'weekly', 'monthly',
    'yearly', ]       $period          = 'daily',
  Boolean             $compress        = true,
  Boolean             $delaycompress   = true,
  Boolean             $missingok       = true,
  Boolean             $ifempty         = true,
  Boolean             $copytruncate    = true
  Boolean             $create          = true,
  Optional[String[1]] $create_mode     = undef
  Optional[Integer]   $size            = undef,

){

  if $::ocserv::ensure in [ present, installed, latest ] {

    file { "${logrotate_dir}/${logrotate_conf}":
      ensure  => $ensure,
      content => epp("${module_name}/logrotate.epp", {
        path          => "${log_dir}/${log_file}",
        logs_count    => $logs_count,
        period        => $period,
        size          => $size,
        compress      => $compress,
        delaycompress => $delaycompress,
        missingok     => $missingok,
        ifempty       => $ifempty,
        copytruncate  => $copytruncate,
        create        => $create,
        create_mode   => $create_mode,
      }),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

  } else {

    file { "${logrotate_dir}/${logrotate_conf}":
      ensure  => $::ocserv::ensure,

  }
}
