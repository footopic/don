Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu14.04"
  config.vm.box_url = "https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.04/ubuntu-14.04-amd64.box"

  config.vm.network "private_network", ip: "192.168.33.105"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
  end

  config.vm.provision :itamae do |config|
    config.sudo = true
    config.shell = '/bin/sh'
    config.recipes = './recipes/roles/footopic/default.rb'
  end
end
