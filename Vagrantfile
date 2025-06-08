# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Wspólna konfiguracja
  config.vm.box = "ubuntu/jammy64"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 1
  end

  # Serwer główny
  config.vm.define "srv-main" do |main|
    main.vm.hostname = "srv-main"
    main.vm.network "private_network", ip: "192.168.56.10"
    main.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
      vb.name = "srv-main"
    end
  end

  # Serwer backup
  config.vm.define "srv-backup" do |backup|
    backup.vm.hostname = "srv-backup"
    backup.vm.network "private_network", ip: "192.168.56.11"
    backup.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "srv-backup"
    end
  end

  # Klient 1
  config.vm.define "client1" do |client|
    client.vm.hostname = "client1"
    client.vm.network "private_network", ip: "192.168.56.101"
    client.vm.box = "ubuntu/jammy64"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "client1"
      vb.gui = true
    end
  end

  # Klient 2
  config.vm.define "client2" do |client|
    client.vm.hostname = "client2"
    client.vm.network "private_network", ip: "192.168.56.102"
    client.vm.box = "ubuntu/jammy64"
    client.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "client2"
      vb.gui = true
    end
  end

  # Provisioning z Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/site.yml"
    ansible.inventory_path = "ansible/inventory.yml"
    ansible.limit = "all"
  end
end
