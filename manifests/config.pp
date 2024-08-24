class ocserv::config (
  Enum['file', 'absent'] $ensure      = 'file',
  String[1]              $config_file = "${::ocserv::base_conf_dir}/ocserv.conf",

  # Auth methods
  Optional[String[1]] $auth_custom             = undef,
  Boolean             $auth_pam                = true,
  Boolean             $auth_plain              = false,
  String[1]           $auth_plain_passwd_file  = "${::ocserv::base_conf_dir}/ocpasswd",
  Boolean             $auth_cert               = false,
  Boolean             $auth_radius             = false,
  Boolean             $auth_radius_groupconfig = true,
  Optional[String[1]] $auth_radius_conf        = undef,
  Optional[String[1]] $auth_plain_otp_file     = undef,

  # TODO add gssapi.
  Optional[Array]     $enable_auth = undef,
  Optional[String[1]] $accounting  = undef,

  # "restart" opts
  String[1]           $listen_host           = '0.0.0.0',
  Integer[1, 65535]   $tcp_port              = 443,
  Integer[1, 65535]   $udp_port              = 443,
  String[1]           $occtl_socket_file     = '/run/occtl.socket',
  String[1]           $socket_file           = '/run/ocserv.socket',
  Optional[String[1]] $ca_cert               = undef,
  Optional[String[1]] $server_cert           = undef,
  Optional[String[1]] $server_key            = undef,
  Optional[String[1]] $listen_host_udp       = undef,
  Optional[Boolean]   $listen_host_is_dyndns = undef,
  Optional[String[1]] $listen_netns          = undef,
  Optional[String[1]] $chroot_dir            = undef,
  Optional[String[1]] $dh_params             = undef,
  Optional[String[1]] $pin_file              = undef,
  Optional[String[1]] $srk_pin_file          = undef,
  Optional[String[1]] $key_pin               = undef,
  Optional[String[1]] $srk_pin               = undef,
  Optional[Integer]   $sec_mod_scale         = undef,

  # "reload" opts
  Boolean             $isolate_workers         = true,
  Integer             $max_clients             = 5,
  Integer             $max_same_clients        = 2,
  Integer             $rate_limit_ms           = 0,
  Integer             $server_stats_reset_time = 604800,
  Integer             $keepalive               = 30,
  Integer             $dpd                     = 60,
  Integer             $mobile_dpd              = 90,
  Integer             $switch_to_tcp_timeout   = 25,
  Boolean             $try_mtu_discovery       = false,
  Integer             $auth_timeout            = 240,
  Integer             $min_reauth_time         = 300,
  Integer             $max_ban_score           = 80,
  Integer             $ban_reset_time          = 1200,
  Integer             $cookie_timeout          = 300,
  Boolean             $deny_roaming            = false,
  Integer             $rekey_time              = 172800,
  String[1]           $rekey_method            = 'ssl',
  Boolean             $use_occtl               = true,
  String[1]           $pid_file                = '/run/ocserv.pid',
  Integer             $log_level               = 0,
  String[1]           $device                  = 'vpns',
  Boolean             $predictable_ips         = false,
  String[1]           $default_domain          = 'example.com',
  String[1]           $ipv4_network            = '192.168.3.0/24',
  Boolean             $tunnel_all_dns          = true,
  Array               $dns                     = [ '8.8.8.8' ,'1.1.1.1' ],
  Boolean             $ping_leases             = false,
  Boolean             $cisco_client_compat     = true,
  Boolean             $dtls_legacy             = true,
  Boolean             $client_bypass_protocol  = false,
  String[1]           $config_per_user         = $::ocserv::per_user_conf_dir,
  String[1]           $config_per_group        = $::ocserv::per_group_conf_dir,


  Optional[String[1]] $banner                    = undef,
  Optional[String[1]] $pre_login_banner          = undef,
  Optional[Boolean]   $listen_proxy_proto        = undef,
  Optional[Integer]   $stats_report_time         = undef,
  Optional[Integer]   $server_drain_ms           = undef,
  Optional[String[1]] $ocsp_response             = undef,
  Optional[String[1]] $cert_user_oid             = undef,
  Optional[String[1]] $cert_group_oid            = undef,
  Optional[String[1]] $crl                       = undef,
  Optional[Boolean]   $compression               = undef,
  Optional[Integer]   $no_compress_limit         = undef,
  Optional[String[1]] $tls_priorities            = undef,
  Optional[Boolean]   $match_tls_dtls_ciphers    = undef,
  Optional[Integer]   $idle_timeout              = undef,
  Optional[Integer]   $session_timeout           = undef,
  Optional[Integer]   $mobile_idle_timeout       = undef,
  Optional[Integer]   $ban_points_wrong_password = undef,
  Optional[Integer]   $ban_points_connection     = undef,
  Optional[Integer]   $ban_points_kkdcp          = undef,
  Optional[Boolean]   $persistent_cookies        = undef,
  Optional[String[1]] $connect_script            = undef,
  Optional[String[1]] $disconnect_script         = undef,
  Optional[String[1]] $host_update_script        = undef,
  Optional[Boolean]   $use_utmp                  = undef,
  Optional[Integer]   $net_priority              = undef,
  Optional[String[1]] $cgroup                    = undef,
  Optional[String[1]] $ipv6_network              = undef,
  Optional[Integer]   $ipv6_subnet_prefix        = undef,
  Optional[String[1]] $nbns                      = undef,
  Optional[String[1]] $split_dns                 = undef,
  Optional[Integer]   $mtu                       = undef,
  Optional[Integer]   $rx_data_per_sec           = undef,
  Optional[Integer]   $tx_data_per_sec           = undef,
  Optional[Integer]   $output_buffer             = undef,
  Optional[Array]     $route                     = undef,
  Optional[String[1]] $no_route                  = undef,
  Optional[Boolean]   $restrict_user_to_routes   = undef,
  Optional[String[1]] $restrict_user_to_ports    = undef,
  Optional[Boolean]   $expose_iroutes            = undef,
  Optional[Array]     $select_group              = undef,
  Optional[Boolean]   $select_group_by_url       = undef,
  Optional[String[1]] $default_select_group      = undef,
  Optional[Boolean]   $auto_select_group         = undef,
  Optional[String[1]] $default_user_config       = undef,
  Optional[String[1]] $default_group_config      = undef,
  Optional[String[1]] $route_add_cmd             = undef,
  Optional[String[1]] $route_del_cmd             = undef,
  Optional[String[1]] $proxy_url                 = undef,
  Optional[String[1]] $kkdcp                     = undef,
  Optional[String[1]] $user_profile              = undef,
  Optional[Boolean]   $dtls_psk                  = undef,

  # Advanced

  Optional[String[1]]  $custom_header     =  undef,
  Optional[String[1]]  $camouflage        =  undef,
  Optional[String[1]]  $camouflage_secret =  undef,
){

  # TODO multiple methods can be enabled.

  if $auth_custom {
    $resulting_auth = $auth_custom

  } elsif $auth_pam {
    $resulting_auth = 'pam'

  } elsif $auth_plain {
    if $auth_plain_otp_file {
      $resulting_otp = ",${auth_plain_otp_file}"
    } else {
      $resulting_otp = ''
    }
    $resulting_auth = "plain[passwd=${auth_plain_passwd_file}${resulting_otp}]"

  } elsif $auth_radius {
    if !$radius_conf {
      fail('$radius_conf must be specified')
    }
    $resulting_auth = "radius[config=${auth_radius_conf},groupconfig=bool2str($auth_radius_groupconfig)]"

  } elsif $auth_cert {
    $resulting_auth = 'certificate'
  } else {
    fail('You have to choose auth method')
  }

  $restart_config = "${::ocserv::base_conf_dir}/restart_config.conf"
  $reload_config = "${::ocserv::base_conf_dir}/reload_config.conf"

  exec {"Concatenate configs":
    command     => "cat ${restart_config} ${reload_config} > ${config_file}",
    provider    => shell,
    alias       => 'concat-configs',
    refreshonly => true,
  }

  file { "${config_file}":
    ensure  => $ensure,
    owner   => "$::ocserv::runas_user",
    group   => "$::ocserv::runas_group",
  }

  file { "${restart_config}":
    ensure  => $ensure,
    content => epp("${module_name}/restart-conf.epp", {
      auth                  => $resulting_auth,
      enable_auth           => $enable_auth,
      acct                  => $accounting,
      listen_host           => $listen_host,
      listen_host_udp       => $listen_host_udp,
      listen_host_is_dyndns => $listen_host_is_dyndns,
      listen_netns          => $listen_netns,
      tcp_port              => $tcp_port,
      udp_port              => $udp_port,
      runas_user            => "$::ocserv::runas_user",
      runas_group           => "$::ocserv::runas_group",
      occtl_socket_file     => $occtl_socket_file,
      socket_file           => $socket_file,
      chroot_dir            => $chroot_dir,
      server_cert           => $server_cert,
      server_key            => $server_key,
      dh_params             => $dh_params,
      pin_file              => $pin_file,
      srk_pin_file          => $srk_pin_file,
      key_pin               => $key_pin,
      srk_pin               => $srk_pin,
      ca_cert               => $ca_cert,
      sec_mod_scale         => $sec_mod_scale,
    }),
    owner   => "$::ocserv::runas_user",
    group   => "$::ocserv::runas_group",
    mode    => '0640',
    notify  => [
      Exec['concat-configs'],
      Exec['ocserv-restart'],
    ],
  }

  file { "${reload_config}":
    ensure  => $ensure,
    content => epp("${module_name}/reload-conf.epp", {
      banner                    => $banner,
      pre_login_banner          => $pre_login_banner,
      isolate_workers           => $isolate_workers,
      max_clients               => $max_clients,
      max_same_clients          => $max_same_clients,
      listen_proxy_proto        => $listen_proxy_proto,
      rate_limit_ms             => $rate_limit_ms,
      stats_report_time         => $stats_report_time,
      server_stats_reset_time   => $server_stats_reset_time,
      keepalive                 => $keepalive,
      dpd                       => $dpd,
      mobile_dpd                => $mobile_dpd,
      switch_to_tcp_timeout     => $switch_to_tcp_timeout,
      try_mtu_discovery         => $try_mtu_discovery,
      auth_timeout              => $auth_timeout,
      min_reauth_time           => $min_reauth_time,
      max_ban_score             => $max_ban_score,
      ban_reset_time            => $ban_reset_time,
      cookie_timeout            => $cookie_timeout,
      deny_roaming              => $deny_roaming,
      rekey_time                => $rekey_time,
      rekey_method              => $rekey_method,
      use_occtl                 => $use_occtl,
      pid_file                  => $pid_file,
      log_level                 => $log_level,
      device                    => $device,
      predictable_ips           => $predictable_ips,
      default_domain            => $default_domain,
      ipv4_network              => $ipv4_network,
      tunnel_all_dns            => $tunnel_all_dns,
      dns                       => $dns,
      ping_leases               => $ping_leases,
      cisco_client_compat       => $cisco_client_compat,
      dtls_legacy               => $dtls_legacy,
      client_bypass_protocol    => $client_bypass_protocol,
      server_drain_ms           => $server_drain_ms,
      ocsp_response             => $ocsp_response,
      cert_user_oid             => $cert_user_oid,
      cert_group_oid            => $cert_group_oid,
      crl                       => $crl,
      compression               => $compression,
      no_compress_limit         => $no_compress_limit,
      tls_priorities            => $tls_priorities,
      match_tls_dtls_ciphers    => $match_tls_dtls_ciphers,
      idle_timeout              => $idle_timeout,
      session_timeout           => $session_timeout,
      mobile_idle_timeout       => $mobile_idle_timeout,
      ban_points_wrong_password => $ban_points_wrong_password,
      ban_points_connection     => $ban_points_connection,
      ban_points_kkdcp          => $ban_points_kkdcp,
      persistent_cookies        => $persistent_cookies,
      connect_script            => $connect_script,
      disconnect_script         => $disconnect_script,
      host_update_script        => $host_update_script,
      use_utmp                  => $use_utmp,
      net_priority              => $net_priority,
      cgroup                    => $cgroup,
      ipv6_network              => $ipv6_network,
      ipv6_subnet_prefix        => $ipv6_subnet_prefix,
      nbns                      => $nbns,
      split_dns                 => $split_dns,
      mtu                       => $mtu,
      rx_data_per_sec           => $rx_data_per_sec,
      tx_data_per_sec           => $tx_data_per_sec,
      output_buffer             => $output_buffer,
      route                     => $route,
      no_route                  => $no_route,
      restrict_user_to_routes   => $restrict_user_to_routes,
      restrict_user_to_ports    => $restrict_user_to_ports,
      expose_iroutes            => $expose_iroutes,
      select_group              => $select_group,
      select_group_by_url       => $select_group_by_url,
      default_select_group      => $default_select_group,
      auto_select_group         => $auto_select_group,
      config_per_user           => $config_per_user,
      config_per_group          => $config_per_group,
      default_user_config       => $default_user_config,
      default_group_config      => $default_group_config,
      route_add_cmd             => $route_add_cmd,
      route_del_cmd             => $route_del_cmd,
      proxy_url                 => $proxy_url,
      kkdcp                     => $kkdcp,
      user_profile              => $user_profile,
      dtls_psk                  => $dtls_psk,
      custom_header             => $custom_header,
      camouflage                => $camouflage,
      camouflage_secret         => $camouflage_secret,
    }),
    owner   => "$::ocserv::runas_user",
    group   => "$::ocserv::runas_group",
    mode    => '0640',
    notify  => [
      Exec['concat-configs'],
      Exec['ocserv-reload'],
    ],
  }
}
