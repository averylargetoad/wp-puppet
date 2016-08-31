# vi: set ft=ruby :

class role {
  if defined( 'profile::base' ) {
    include 'profile::base'
  }
}
