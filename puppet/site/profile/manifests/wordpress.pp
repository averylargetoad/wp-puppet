# vi: set ft=ruby :

class profile::wordpress (
  String $http_port = '80',
  String $wp_host = 'wordpress',
  String $wp_home = '/opt/wordpress',
  String $db_host = 'localhost',
  String $db_root = 'password',
  String $db_name = 'wordpress',
  String $db_user = 'wordpress',
  String $db_pass = 'wordpress',
  String $db_port = '3306',
  String $app_hosts = '%',
  String $service = 'wordpress',
  Array  $servers = [ 'localhost' ],
  Array  $ipaddrs = [ '127.0.0.1' ],
  String $svc_port  = '%{http_port}',
) inherits profile {

}
