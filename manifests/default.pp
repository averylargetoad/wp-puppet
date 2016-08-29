#wordpress_app { 'tiered':
wordpress_app::simple { 'all_in_one':
  nodes => {
    Node['wp01.vagrant.test'] => [
      Wordpress_app::Database['all_in_one'],
      Wordpress_app::Web['all_in_one'],
    ]
  #nodes => {
    #Node['db01.vagrant.test'] => Wordpress_app::Database['wordpress-db'],
    #Node['lb01.vagrant.test'] => Wordpress_app::Lb['tiered'],
    #Node['wp01.vagrant.test'] => Wordpress_app::Web['tiered-web01'],
    #Node['wp02.vagrant.test'] => Wordpress_app::Web['wordpress-web02'],
  }
}
