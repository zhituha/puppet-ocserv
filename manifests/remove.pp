class ocserv::remove {

  package { "$::ocserv::package_name":
    ensure => $::ocserv::ensure,
  }

  if $::ocserv::ensure == 'purged':
    if $::ocserv::log_dir != '/var/log' {
      $rm_dirs = [ "${::ocserv::base_conf_dir}", "${::ocserv::log_dir}" ]
    } else {
      $rm_dirs = [ "${::ocserv::base_conf_dir}" ]
    }

    file { $rm_dirs:  
      ensure  => absent,
      force   => true,
      recurse => true,
  }

}
