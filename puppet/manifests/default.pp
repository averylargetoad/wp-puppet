# -*- mode: ruby -*-
# vi: set ft=ruby :

# vi: set ft=ruby :

#node /^wp-[a-z]{2}[0-9]{2}/ {
#  include roles::wordpress
#}

node /^wp-ws[0-9]{2}/ {
  include role::wordpress::wpws
}

node /^wp-db[0-9]{2}/ {
  include role::wordpress::wpdb
}

node /^wp-ha[0-9]{2}/ {
  include role::wordpress::wpha
}
#hiera_include('classes')

#node default {
#  hiera_include('classes')
#}

# vi: set ft=ruby :

#$db_name = 'wordpress'
#$db_user = 'wordpress'
#$db_pass = 'wp_pass02'
#
#node /^wp.*/ {
#  include roles::wordpress::wp
#
#  class { '::apache':
#    default_vhost => false,
#    file_mode     => '0640',
#    mpm_module    => 'prefork',
#  }
#
#  package { 'php-mysql':
#    ensure => 'installed',
#  }
#
#  class { '::apache::mod::php': }
#
#  apache::vhost { 'wp.vagrant.test':
#    port             => '80',
#    docroot          => '/opt/wordpress',
#  }
#
#  class { '::wordpress':
#    create_db      => false,
#    create_db_user => false,
#    db_name        => $db_name,
#    db_password    => $db_pass,
#    db_host        => 'db01.vagrant.test',
#  }
#  
#  file { '/opt/wordpress/wp-config-sample.php':
#    ensure => 'absent',
#  }
#
#  firewall { '100 allow http':
#    chain  => 'IN_public_allow',
#    state  => 'NEW',
#    dport  => [80],
#    proto  => tcp,
#    action => accept,
#  }
#}
#
#node /^db.*/ {
#  include roles::wordpress::db
#
#  class { '::mysql::server':
#    root_password    => 'password',
#    override_options => { 'mysqld' => { 'bind_address' => $ip } }
#  }
#
#  class { '::mysql::bindings':
#    php_enable => true
#  }
#
#  include mysql::client
#
#  $my_prefix = netmask_to_masklen($netmask)
#  $my_network = inline_epp('<%= $network -%>/<%= $my_prefix -%>')
#
#  mysql::db { $db_name:
#    user     => $db_user,
#    password => $db_pass,
#    host     => 'wp%.vagrant.test',
#    grant    => 'ALL',
#  }
#
#  firewall { '100 allow mysql':
#    chain  => 'IN_public_allow',
#    state  => 'NEW',
#    #source => $my_network,
#    dport  => [3306],
#    proto  => tcp,
#    action => accept,
#  }
#}
#
#node /^ha.*/ {
#  include roles::wordpress::db
#
#  include ::haproxy
#  haproxy::listen { 'wordpress':
#    collect_exported => false,
#    ipaddress        => $ipaddress,
#    ports            => '80',
#  }
#  haproxy::balancermember { 'wp01.vagrant.test':
#    listening_service => 'wordpress',
#    server_names      => ['wp01', 'wp02'],
#    ipaddresses       => ['172.28.128.3', '172.28.128.4'],
#    ports             => '80',
#    options           => 'check',
#  }
#
#  firewall { '100 allow http':
#    chain  => 'IN_public_allow',
#    state  => 'NEW',
#    dport  => [80],
#    proto  => tcp,
#    action => accept,
#  }
#}
