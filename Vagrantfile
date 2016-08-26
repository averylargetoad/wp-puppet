# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.landrush.enabled = true

  config.vm.box = "puppetlabs/centos-7.2-64-puppet"
  #config.vm.box = "hashicorp/precise64"
  config.vm.box_check_update = false
  config.vm.guest = "redhat"

  config.vm.define "wp01" do |wp01|
    wp01.vm.hostname = "wp01.vagrant.test"
    wp01.vm.network "forwarded_port", guest: 80, host: 8080
  end


  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
 
    # Customize the amount of memory on the VM:
    vb.memory = "768"
  end

  config.vm.provision "shell",
    inline: "chmod 0600 ~vagrant/.ssh/authorized_keys"

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
    #puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
  end
end
