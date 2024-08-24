class ocserv::install {

  if $::ocserv::configure_logrotate {
    contain ocserv::logrotate
  }

  if $::ocserv::package_version {
    $resulting_ensure = $::ocserv::package_version
  } else {
    $resulting_ensure = $::ocserv::ensure
  }

  package { "$::ocserv::package_name":
    ensure => $resulting_ensure,
  }

  file { [
    "$::ocserv::per_user_conf_dir",
    "$::ocserv::per_group_conf_dir"
    ]:  
    ensure  => directory,
    purge   => true,
    force   => true,
    recurse => true,
    mode    => '0750',
    owner   => "$::ocserv::runas_user",
    group   => "$::ocserv::runas_group",
    require => Package["$::ocserv::package_name"],
  }
}
