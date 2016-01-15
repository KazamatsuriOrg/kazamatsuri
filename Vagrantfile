# -*- mode: ruby -*-
# vi: set ft=ruby :

# Helper for boilerplate involved with setting resource limits across providers
def set_limits(box, cpus: cpus, memory: memory)
  box.vm.provider "virtualbox" do |vb|
    vb.memory = memory
    vb.cpus = cpus
  end
  
  box.vm.provider "vmware_fusion" do |vw|
    vw.vmx["memsize"] = memory
    vw.vmx["numvcpus"] = cpus
  end
end

NUM_WEB = 2

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # Use a Debian 8.2 base box for all machines
  config.vm.box = "box-cutter/debian82"
  
  config.vm.define "jena", primary: true do |jena|
    # Set resource limits
    set_limits jena, cpus: 1, memory: 1024
    
    # Forward ports to the host machine
    jena.vm.network "forwarded_port", guest: 80, host: 8080
    
    # Create a private network between the machines
    jena.vm.network "private_network", ip: "10.10.10.10"
    
    # Provision using Salt
    jena.vm.provision "salt" do |salt|
      salt.bootstrap_options = "-F -c /tmp -i jena"
      salt.install_master = true
      salt.minion_config = "vagrant/jena/salt_minion.yml"
      salt.minion_key = "vagrant/jena/jena.pem"
      salt.minion_pub = "vagrant/jena/jena.pub"
      salt.master_config = "vagrant/jena/salt_master.yml"
      salt.seed_master = { jena: salt.minion_pub }
      salt.run_highstate = true
      salt.colorize = true
    end
  end
  
  (1..NUM_WEB).each do |i|
    config.vm.define "web#{i}" do |web|
      set_limits web, cpus: 1, memory: 1024
      web.vm.network "private_network", ip: "10.10.10.1#{i}"
      web.vm.provision "salt" do |salt|
        salt.bootstrap_options = "-F -c /tmp -i web#{i}"
        salt.minion_config = "vagrant/web/salt_minion.yml"
        salt.run_highstate = true
        salt.colorize = true
      end
    end
  end
  
  config.vm.define "minecraft", autostart: false do |mcraft|
    set_limits mcraft, cpus: 1, memory: 1024
    mcraft.vm.network "private_network", ip: "10.10.10.101"
    mcraft.vm.provision "salt" do |salt|
      salt.bootstrap_options = "-F -c /tmp -i minecraft"
      salt.minion_config = "vagrant/minecraft/salt_minion.yml"
      salt.run_highstate = true
      salt.colorize = true
    end
  end
end
