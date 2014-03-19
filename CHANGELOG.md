## v1.11 (Planned)

* 

## v1.10 (March 18th, 2014)

* Ensure WinRM service starts immediately rather than after 120 seconds (#43)

## v1.9 (March 14th, 2014)

* Add support for Windows 8.1
* Add port forwarding for WinRM (5985) by default, with vagrant auto-correct enabled
* Require the use of the vagrant-windows plugin in the Vagrantfile templates

## v1.8 (March 7th, 2014)

* Updated oracle.cer to allow installation of VirtualBox tools

## v1.7 (February 26, 2014)

* Add support for Windows 7 Enterprise
* Add support for Windows 2008 R2 Core
* Add support for Windows 2012 R2 Core
* Remove port forwarding from Vagrantfile templates
* Update Puppet version in scripts/puppet.bat

## v1.6 (January 20, 2014)

* Remove `config.vm.base_mac = "{{ .BaseMacAddress }}"` from vagrantfile templates, ensure SCSI controller is set in VMX (fixes #26)

## v1.5 (January 9, 2014)

* Fix issue with installation of VM guest tools [GH-23]

## v1.4 (December 31, 2013)

* Update .json files to work with Packer 0.5.0 (the `vmware` builder is renamed to `vmware-iso`, the `virtualbox` builder is renamed to `virtualbox-iso`)
* Update README with better examples for using retail custom ISO files and disabling Windows Update installation

## v1.3 (December 18, 2013)

* Allow Packer to upload VMware Tools by default, but fall back to downloading the tools from VMware if required
* Update SCSI bus type for the hard disk in a VMware VM to permit Windows 2012 R2 to install correctly
* Fix Windows 2012 R2 issue where the `vagrant` user did not have its password set
* Fix Windows 2012 R2 issue where autologon only works once

## v1.2 (December 18, 2013)

* Add support for Windows 2012 and Windows 2012 R2
* Switch all configurations to use Microsoft trial images that are publicly accessible so that you do not need MSDN or TechNet to use this repo

## v1.1 (December 17, 2013)

* Initial release, including working Windows 2008 R2 configuration
