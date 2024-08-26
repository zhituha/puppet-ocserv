# Configure a logrotate.
# @param logrotate_dir Base dir for logrotate configs in your system. Default: '/etc/logrotate.d/'
# @param logrotate_conf Filename for an ocserv's config. Default: 'ocserv.conf'
# @param log_dir Dir where to store logs. Default: '/var/log'
# @param log_file Filename for an ocserv's logfile. Default: 'ocserv.log'
# @param logs_count How many logs you'd like to keep on a disk. Default: 7
# @param period Period of rotating.  Default: 'daily'
# @param compress Either compress logs or not. Default: true
# @param delaycompress Postpone compressing current active logfile to the next rotation. Default: true
# @param missingok Do not throw an error if some logfile is missing. Just go to the next one. Default: true
# @param ifempty Either rotate or not empty logs. Default: true
# @param copytruncate Truncate the original log after creating a copy instead of moving and creating a new one. Default: true
# @param create Create new logfile immediately after rotating. Default: true
# @param create_mode Set filemode, ownar, and group for the new logfile.
# @param size Rotate logfile only if it grow bigger than specified size.

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
