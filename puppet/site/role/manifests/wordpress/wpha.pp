# vi: set ft=ruby :
class role::wordpress::wpha inherits role::wordpress {
  include profile::wordpress::wpha
}
