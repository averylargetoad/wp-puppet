# vi: set ft=ruby :

node /^wp-[a-z]{2}[0-9]{2}/ {
  app_role = "wp"
  include role::wordpress
}

node /^wp-ws[0-9]{2}/ {
  include role::wordpress::wpws
  node_role = "wp-ws"
}

node /^wp-db[0-9]{2}/ {
  include role::wordpress::wpdb
  node_role = "wp-db"
}

node /^wp-ha[0-9]{2}/ {
  include role::wordpress::wpha
  node_role = "wp-ha"
}
