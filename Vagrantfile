# -*- mode: ruby -*-
# vi: set ft=ruby :

# Helper for boilerplate involved with setting resource limits across providers
def set_limits(box, cpus: cpus, memory: memory)
  box.vm.provider "virtualbox" do |vb|
    vb.memory = memory
    vb.cpus = cpus
  end
  
  box.vm.provider "vmware" do |vw|
    vw.vmx["memsize"] = memory
    vw.vmx["numvcpus"] = cpus
  end
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # Use a Debian 8.2 base box for all machines
  config.vm.box = "box-cutter/debian82"
  
  config.vm.define "back" do |back|
    # Set resource limits
    set_limits back, cpus: 2, memory: 1024
    
    # Create a private network between the machines
    back.vm.network "private_network", ip: "10.10.10.11"
    
    # Provision using Salt
    back.vm.provision "salt" do |salt|
      salt.bootstrap_options = "-F -c /tmp"
      salt.minion_config = "vagrant/back/salt_minion.yml"
      salt.run_highstate = true
    end
  end
  
  config.vm.define "web" do |web|
    # Set resource limits
    set_limits web, cpus: 2, memory: 2048
    
    # Forward ports to the host machine
    web.vm.network "forwarded_port", guest: 80, host: 8080
    
    # Create a private network between the machines
    web.vm.network "private_network", ip: "10.10.10.10"
    
    # Provision using Salt
    web.vm.provision "salt" do |salt|
      salt.bootstrap_options = "-F -c /tmp"
      salt.minion_config = "vagrant/web/salt_minion.yml"
      salt.run_highstate = true
    end
  end
end
