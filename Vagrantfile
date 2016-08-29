# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = ".vagrant.test"

app_nodes = [ {
    node_type: "wp",
    num_nodes: 2,
    vm_mb_ram: 512,
    ports_fwd: [ 
      { guest: 80, host: 8080 } ],
  }, {
    node_type: "db",
    num_nodes: 1,
    vm_mb_ram: 768,
    ports_fwd: [],
  }, {
    node_type: "ha",
    num_nodes: 1,
    vm_mb_ram: 512,
    ports_fwd: [
      { guest: 80, host:8880 } ],
    public_ip: true
  }
]
 
Vagrant.configure("2") do |config|
  config.landrush.enabled = true

  config.vm.box = "puppetlabs/centos-7.2-64-puppet"
  #config.vm.box = "hashicorp/precise64"
  config.vm.box_check_update = false
  config.vm.guest = "redhat"
  config.vm.network "private_network", type: "dhcp"
 
  app_nodes.each do |tier|
    n = tier[:num_nodes]
    (1..n).each do |i|
      node_name = tier[:node_type] + "%02d" % i
      config.vm.define node_name do |node|
        node.vm.hostname = node_name + domain
        tier[:ports_fwd].each do |fwd_port|
          node.vm.network "forwarded_port", guest: fwd_port[:guest], host: fwd_port[:host]+i
        end
        if tier[:public_ip] then 
          node.vm.network "public_network", bridge: [ "Intel(R) 82578DM Gigabit Network Connection", ]
        end 
        node.vm.provider "virtualbox" do |v|
          v.gui = false
          v.linked_clone = true
          v.customize ["modifyvm", :id, "--memory", tier[:vm_mb_ram] ]
        end
      end
    end
  end
 
# db_nodes = 2

# (1..db_nodes).each do |i|
#   node_name = "db%02d" % i
#   config.vm.define node_name do |node|
#     node.vm.hostname = node_name + domain
#     node.vm.provider "virtualbox" do |vb|
#       v.gui = false
#       v.linked_clone = true
#       v.customize = ["modifyvm", :id, "--memory", 1024]
#     end
#   end
# end

  config.vm.provision "shell", inline: <<-SHELL
  chmod 0600 ~vagrant/.ssh/authorized_keys
  sudo yum -q -y makecache fast 
  sudo `which puppet` apply --modulepath=/vagrant/modules /vagrant/manifests/default.pp
  SHELL

  #config.vm.provision "puppet" do |puppet|
  #  puppet.module_path = "modules"
  #  puppet.manifests_path = "manifests"
  #  puppet.manifest_file = "site.pp"
  #end
end
