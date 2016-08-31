# vi: set ft=ruby :

class profile::wordpress::wpws (
  String $http_port = '80',
  String $db_name = 'wordpress',
  String $db_pass = 'wordpress',
  String $wp_host = 'wordpress',
  String $wp_home = '/opt/wordpress',
  String $db_host = 'localhost',
) inherits profile::wordpress {

  class { '::apache':
    default_vhost => false,
    file_mode     => '0640',
    mpm_module    => 'prefork',
  }

  package { 'php-mysql':
    ensure => 'installed',
  }

  class { '::apache::mod::php': }

  apache::vhost { $wp_host:
    port             => $http_port,
    docroot          => $wp_home,
  }

  class { '::wordpress':
    create_db      => false,
    create_db_user => false,
    db_name        => $db_name,
    db_password    => $db_pass,
    db_host        => $db_host,
  }
  $wp_sample_config = "${wp_home}/wp-config-sample.php"
  file { $wp_sample_config:
    ensure => 'absent',
  }

  firewall { '100 allow http':
    chain  => 'IN_public_allow',
    state  => 'NEW',
    dport  => [ $http_port ],
    proto  => tcp,
    action => accept,
  }
}

