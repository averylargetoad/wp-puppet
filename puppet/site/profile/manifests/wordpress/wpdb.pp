# vi: set ft=ruby :
class profile::wordpress::wpdb (
  String $db_root = 'password',
  String $db_user = 'wordpress',
  String $db_pass = 'wordpress',
  String $db_name = 'wordpress',
  String $db_port = '3306',
  String $app_hosts = '%',
) inherits profile::wordpress {

  class { '::mysql::server':
    root_password    => $db_root,
    override_options => { 'mysqld' => { 'bind_address' => $ip } }
  }

  class { '::mysql::bindings':
    php_enable => true
  }

  include mysql::client

  $my_prefix = netmask_to_masklen($netmask)
  $my_network = inline_epp('<%= $network -%>/<%= $my_prefix -%>')

  mysql::db { $db_name:
    user     => $db_user,
    password => $db_pass,
    host     => inline_epp('<%= $app_hosts -%>.<%= $domain -%>'),
    grant    => 'ALL',
  }

  firewall { '100 allow mysql':
    chain  => 'IN_public_allow',
    state  => 'NEW',
    #source => $my_network,
    dport  => [ $db_port ],
    proto  => tcp,
    action => accept,
  }
}

