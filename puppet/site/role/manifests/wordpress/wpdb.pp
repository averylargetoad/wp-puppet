# vi: set ft=ruby :
class role::wordpress::wpdb inherits role::wordpress {
  include profile::wordpress::wpdb
}
