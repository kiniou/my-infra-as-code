require 'yaml'
require 'pp'

def debug(obj)
  if ENV.fetch("DEBUG", false)
    pp(obj)
  end
end

def warn(obj)
  if ENV.fetch("DEBUG", false)
    puts obj
  end
end
# Hashes recursive merge enhancement
class ::Hash
  def rmerge!(other_hash)
    merge!(other_hash) do |key, oldval, newval|
      oldval.class == self.class ? oldval.rmerge!(newval) : newval
    end
  end

  def rmerge(second)
    r = {}
    merge(second) do |key, oldval, newval|
      r[key] = oldval.class == self.class ? oldval.rmerge(newval) : newval
    end
  end
end

vms = YAML.load_file(File.join(File.dirname(__FILE__), 'vms.yml'))
begin
  vms_custom = YAML.load_file(File.join(File.dirname(__FILE__), 'vms.override.yml'))
  vms = vms.rmerge(vms_custom)
rescue Exception => e
  warn("WARNING: %s" % e)
end
debug(vms)

def configure_node_vm(node, data)
  synced_volumes = {
    '/srv/salt' => '.',
  }.rmerge(data.fetch('synced_volumes', {}))

  synced_volumes_type = data.fetch('synced_volumes_type', 'default')

  # Defaults
  memory = 2048
  cpus = 1

  # Libvirt setup
  node.vm.provider "libvirt" do |lv, override|
    lv.cpus = data.fetch("cpus", cpus)
    lv.memory = data.fetch("memory", memory)
    lv.cpu_mode = 'host-passthrough'
    lv.graphics_type = 'spice'
    lv.video_type = 'virtio'
    synced_volumes.each do |dest, src|
      if synced_volumes_type == 'nfs'
        override.vm.synced_folder src, dest, type: 'nfs'
      else
        override.vm.synced_folder src, dest, type: '9p', accessmode: "squash"
      end
    end
  end

  # Virtualbox setup
  node.vm.provider "virtualbox" do |vb, override|
    vb.auto_nat_dns_proxy = false
    # vb.name = node.vm.hostname
    vb.customize [ "storagectl", :id,
                   "--name", "SATA Controller",
                   "--controller", "IntelAHCI",
                   "--portcount", "4",
                   "--hostiocache", "on" ]
    vb.cpus = data.fetch("cpus", cpus)
    vb.memory = data.fetch("memory", memory)
    override.vm.network "private_network", :type => 'dhcp', :ip => "10.43.0.1", :autoconfig => false
    vb.customize ['modifyvm', :id,
                  '--natdnshostresolver1', 'off',
                  '--natdnshostresolver2', 'off',
                  '--natdnsproxy1', 'on',
                  '--natdnsproxy2', 'off',
                  '--nicpromisc1', 'allow-all',
                  '--nicpromisc2', 'allow-all']
    synced_volumes.each do |dest, src|
      if synced_volumes_type == 'nfs'
        override.vm.synced_folder src, dest, type: 'nfs'
      else
        override.vm.synced_folder src, dest, type: 'virtualbox', automount: true
      end
    end
  end
end

def configure_node_disk(node, idx, vm_name, name, size)
  node.vm.provider "libvirt" do |lv|
    lv.storage :file, :size => "%dG" % size, :path => '%s_%s.img' % [vm_name, name], :type => 'qcow2'
  end
  node.vm.provider "virtualbox" do |vb|
    disk_name = ".vagrant/%s_%s.vdi" % [vm_name, name]
    unless File.exist?(disk_name)
      vb.customize ['createhd', '--filename', disk_name, '--variant', 'Standard', '--size', size * 1024]
    end
    vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', idx + 1, '--device', 0, '--type', 'hdd', '--medium', disk_name]
  end
end

def configure_salt_provision(node, salt_options, vms)
  node.vm.provision :salt do |salt|
    salt.masterless = salt_options.fetch('masterless', true)
    salt.python_version = salt_options.fetch('python_version', 3)
    salt.install_type = salt_options.fetch('install_type', "stable")
    # don't run highstate on `vagrant up`
    salt.run_highstate = false
    if salt.install_type == "git"
      salt.install_args = salt_options.fetch('install_args', salt.version)
    else
      salt.version = salt_options.fetch('version', '3001')
    end
    salt.install_master = salt_options.fetch('install_master', false)
  end
end

Vagrant.configure("2") do |config|

  vms.each do |name, data|
    config.vm.box = data.fetch('box', "kiniou/buster64")
    config.vbguest.auto_update = false
    autostart=data.fetch('autostart', false)
    config.vm.define name, autostart: autostart do |node|
      node.vm.hostname = name
      configure_node_vm(node, data)
      data.fetch('disks', []).each_with_index do |disk,idx|
        debug("Disk %s : %s" % [idx, disk])
        configure_node_disk(node, idx, name, *disk)
      end
      provision = data.fetch('provision', [])
      debug(provision)
      provision.each do |provision_type, provision_data|
        debug("provision '%s' : '%s'" % [provision_type, provision_data])
        if provision_type == 'salt'
          configure_salt_provision(node, provision_data, vms)
        elsif provision_type == 'shell'
            node.vm.provision "shell", inline: provision_data
        end
      end
    end
  end

end
