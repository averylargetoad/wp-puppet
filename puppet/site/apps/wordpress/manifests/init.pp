# -*- mode: ruby -*-
# vi: set ft=ruby :

class ::apps::wordpress {
  node /^wp[a-z]{2}[0-9]{}/ {
    include ::roles::wordpress
  }
}
