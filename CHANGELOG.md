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