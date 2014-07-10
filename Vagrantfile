#require 'vagrant-hp-plugin'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"

  config.vm.provision "shell", path: "resources/puppet/scripts/bootstrap.sh"

  config.vm.provision "puppet" do |puppet|
      #puppet.hiera_config_path = "resources/puppet/hiera.yaml"
      #puppet.working_directory = "/vagrant/resources/puppet"
      puppet.manifests_path = "resources/puppet/manifests"
      puppet.manifest_file  = "base.pp"
  end

  config.vm.define "mininet" do |mininet|
    mininet.vm.box = "dummy"
    mininet.vm.hostname = "mininet"
    #mininet.vm.network "private_network", ip: "192.168.50.15"
    mininet.vm.provider :hp do |rs|
      rs.access_key = "#{ENV['OS_ACCESS_KEY']}"
      rs.secret_key = "#{ENV['OS_SECRET_KEY']}"
      rs.flavor   = "standard.xsmall"
      rs.tenant_id = "#{ENV['OS_TENANT_ID']}"
      rs.server_name = "mininet"
      # Ubuntu Server 14.04 LTS
      rs.image    = "ca2e362c-62c9-4c0d-82a6-5d6a37fcb251" 
      rs.keypair_name = "#{ENV['OS_KEYPAIR_NAME']}"
      rs.ssh_private_key_path = "~/.ssh/id_rsa"
      rs.ssh_username = "ubuntu"
      rs.availability_zone = "az3"
      # Security Groups defaults to ["default"]
      rs.security_groups = ["default", "webserver"]
    end

    mininet.vm.provision "puppet" do |puppet|
      #puppet.hiera_config_path = "resources/puppet/hiera.yaml"
      #puppet.working_directory = "/vagrant/resources/puppet"
      puppet.manifests_path = "resources/puppet/manifests"
      puppet.manifest_file  = "mininet.pp"
    end
  end

  config.vm.define "devstack-control" do |dsctl|
    dsctl.vm.hostname = "devstack-control"
    dsctl.vm.provider :hp do |rs|
      rs.access_key = "#{ENV['OS_ACCESS_KEY']}"
      rs.secret_key = "#{ENV['OS_SECRET_KEY']}"
      rs.flavor   = "standard.small"
      rs.tenant_id = "#{ENV['OS_TENANT_ID']}"
      rs.server_name = "devstack-control"
      # Ubuntu Server 14.04 LTS
      rs.image    = "ca2e362c-62c9-4c0d-82a6-5d6a37fcb251"
      rs.keypair_name = "#{ENV['OS_KEYPAIR_NAME']}"
      rs.ssh_private_key_path = "~/.ssh/id_rsa"
      rs.ssh_username = "ubuntu"
      rs.availability_zone = "az3"
      # Security Groups defaults to ["default"]
      rs.security_groups = ["default", "webserver"]
    end

    dsctl.vm.provision "puppet" do |puppet|
      #puppet.hiera_config_path = "resources/puppet/hiera.yaml"
      #puppet.working_directory = "/vagrant/resources/puppet"
      puppet.manifests_path = "resources/puppet/manifests"
      puppet.manifest_file  = "devstack-control.pp"
    end
  end



end
