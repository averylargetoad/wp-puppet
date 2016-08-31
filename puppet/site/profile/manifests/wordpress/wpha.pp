# vi: set ft=ruby :
class profile::wordpress::wpha (
  String $service = 'wordpress',
  Array  $servers = [ 'localhost' ],
  Array  $ipaddrs = [ '127.0.0.1' ],
  String $svc_port  = '80',
) inherits profile::wordpress {

  include ::haproxy
  haproxy::listen { 'wordpress':
    collect_exported => false,
    ipaddress        => $ipaddress,
    ports            => $svc_port,
  }
  haproxy::balancermember { $service + '_haproxy':
    listening_service => $service,
    server_names      => $servers,
    ipaddresses       => $ipaddrs,
    ports             => $svc_port,
    options           => 'check',
  }

  firewall { '100 allow http':
    chain  => 'IN_public_allow',
    state  => 'NEW',
    dport  => [ $svc_port ],
    proto  => tcp,
    action => accept,
  }
}
