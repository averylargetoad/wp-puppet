# vi: set ft=ruby :
class role::wordpress::wpws inherits role::wordpress {
  include ::profile::wordpress::wpws
}
