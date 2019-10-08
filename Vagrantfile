# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  required_plugins = %w( vagrant-vbguest vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin? plugin
      system "vagrant plugin install #{plugin}"
      _retry=true
    end
 end

  if (_retry)
    exec "vagrant " + ARGV.join(' ')
  end

  # Load custom vbguest installer
  if defined?(VagrantVbguest::Installers::Debian)

      require_relative 'utility/vbg-installer'
      config.vbguest.installer = Utility::DebianCustom
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define "dev" do |d|
    d.vm.box = "debian/stretch64"
    d.vm.hostname = "dev"
    d.vm.network "private_network", ip: "10.100.100.100"
    d.vm.provision :shell, path: "scripts/bootstrap-dev.sh"
    d.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 2048
      v.cpus = 2
      v.customize ["modifyvm", :id, "--audio", "none"]
    end
    d.trigger.after :up do |t|
        t.info = "rsync auto"
        t.run = {inline: "vagrant rsync-auto dev"}
    end
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      d.vm.synced_folder ".vagrant", "/vagrant/.vagrant", mount_options: ["dmode=700,fmode=600"], type: 'rsync'
      d.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"], type: "rsync", rsync__exclude: [".git/", ".idea/", "symfony/"]
      d.vm.synced_folder "./symfony", "/var/www/symfony", mount_options: ["dmode=700,fmode=600"], type: "rsync", rsync__auto: true
    else
      d.vm.synced_folder ".vagrant", "/vagrant/.vagrant", type: 'rsync'
      d.vm.synced_folder ".", "/vagrant", type: 'rsync', rsync__exclude: [".git/", ".idea/", "symfony/"]
      d.vm.synced_folder "./symfony", "/var/www/symfony", type: "rsync", rsync__auto: true
    end
  end

end