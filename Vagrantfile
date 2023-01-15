# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.box = "shekeriev/debian-11"

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 2048
    v.cpus = 1
  end

  # Apache Kafka Machines - Debian 11
    config.vm.define "kafka-1" do |kafka|
      kafka.vm.hostname = "kafka-1"
      kafka.vm.network "private_network", ip: "192.168.98.101"
      kafka.vm.synced_folder "shared/", "/shared"
      kafka.vm.provision "shell", path: "initial-config/add_hosts.sh"
      kafka.vm.provision "shell", path: "initial-config/docker-setup.sh"
      kafka.vm.provision "shell", path: "initial-config/kafka-setup.sh"
      kafka.vm.provision "shell", path: "initial-config/node-exp.sh"
    end

  
  # Monitoring Machine - Debian 11
    config.vm.define "monitoring" do |monitoring|
      monitoring.vm.hostname = "monitoring"
      monitoring.vm.network "private_network", ip: "192.168.98.104"
      monitoring.vm.synced_folder "shared/", "/shared"
      monitoring.vm.provision "shell", path: "initial-config/add_hosts.sh"
      monitoring.vm.provision "shell", path: "initial-config/docker-setup.sh"
      monitoring.vm.provision "shell", path: "initial-config/prometeus-setup.sh"
    end

end
