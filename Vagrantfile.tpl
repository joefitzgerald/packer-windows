# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.2"

Vagrant.configure("2") do |config|
	config.vm.box = "{{.OSName}}"
	config.vm.communicator = "winrm"

	# Admin user name and password
	config.winrm.username = "{{.Username}}"
	config.winrm.password = "{{.Password}}"

	config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
	config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true

	config.vm.provider :virtualbox do |v, override|
		v.customize ["modifyvm", :id, "--memory", {{.RAM}}]
		v.customize ["modifyvm", :id, "--cpus", {{.CPU}}]
		v.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
	end

  config.vm.provider :vmware_fusion do |v, override|
		v.vmx["memsize"] = "{{.RAM}}"
		v.vmx["numvcpus"] = "{{.CPU}}"
		v.vmx["ethernet0.virtualDev"] = "vmxnet3"
		v.vmx["RemoteDisplay.vnc.enabled"] = "false"
		v.vmx["RemoteDisplay.vnc.port"] = "5900"
		v.vmx["scsi0.virtualDev"] = "lsisas1068"
	end

	config.vm.provider :vmware_workstation do |v, override|
		v.vmx["memsize"] = "{{.RAM}}"
		v.vmx["numvcpus"] = "{{.CPU}}"
		v.vmx["ethernet0.virtualDev"] = "vmxnet3"
		v.vmx["RemoteDisplay.vnc.enabled"] = "false"
		v.vmx["RemoteDisplay.vnc.port"] = "5900"
		v.vmx["scsi0.virtualDev"] = "lsisas1068"
	end
end
