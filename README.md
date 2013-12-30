# Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create boxes for Vagrant using Packer ([Website](packer.io)) ([Github](http://github.com/mitchellh/packer)).

This repo began by borrowing bits from the VeeWee Windows templates (https://github.com/jedi4ever/veewee/tree/master/templates). Modifications were made to work with Packer and the VMware Fusion provider for Packer and Vagrant.

### Windows Versions

The following Windows versions are known to work (built with VMware Fusion 6.0.2):

* Windows 2008 R2
  * [![Build Status - Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-develop-2008-r2)](https://packer.ci.cloudbees.com/job/packer-windows-develop-2008-r2/) `Develop`
  * [![Build Status - Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-master-2008-r2)](https://packer.ci.cloudbees.com/job/packer-windows-master-2008-r2/) `Master`
* Windows 2012
  * [![Build Status - Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-develop-2012)](https://packer.ci.cloudbees.com/job/packer-windows-develop-2012/) `Develop`
  * [![Build Status - Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-master-2012)](https://packer.ci.cloudbees.com/job/packer-windows-master-2012/) `Master`
* Windows 2012 R2
  * [![Build Status - Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-develop-2012-r2)](https://packer.ci.cloudbees.com/job/packer-windows-develop-2012-r2/) `Develop`
  * [![Build Status - Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-master-2012-r2)](https://packer.ci.cloudbees.com/job/packer-windows-master-2012-r2/) `Master`

### Windows Editions

All Windows Server versions are defaulted to the Server Standard edition. You can modify this by editing the Autounattend.xml file, changing the `ImageInstall`>`OSImage`>`InstallFrom`>`MetaData`>`Value` element (e.g. to Windows Server 2012 R2 SERVERDATACENTER). You also need to update the `UserData`>`ProductKey` element with the appropriate key from http://technet.microsoft.com/en-us/library/jj612867.aspx.

### Windows Updates

The scripts in this repo will install all Windows updates – by default – during Windows Setup. This is a _very_ time consuming process, depending on the age of the OS and the quantity of updates released since the last service pack. You might want to do yourself a favor during development and disable this functionality, by commenting out this First Logon Command:

```
<SynchronousCommand wcm:action="add">
	<CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\win-updates.ps1</CommandLine>
	<Description>Install Windows Updates</Description>
	<Order>100</Order>
	<RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
```

Doing so will give you hours back in your day, which is a good thing.

### OpenSSH / WinRM

Currently, [Packer](http://packer.io) has a single communitator that uses SSH. This means we need an SSH server installed on Windows - which is not optimal as we could use WinRM to communicate with the Windows VM. In the short term, everything works well with SSH; in the medium term, work is underway on a WinRM communicator for Packer. 

If you have serious objections to OpenSSH being installed, you can always add another stage to your build pipeline:

* Build a base box using Packer
* Create a Vagrantfile, use the base box from Packer, connect to the VM via WinRM (using the [vagrant-windows](https://github.com/WinRb/vagrant-windows) plugin) and disable the 'sshd' service or uninstall OpenSSH completely
* Perform a Vagrant run and and output a .box file

### Using .box Files With Vagrant

If you are going to use the .box files produced by the project with Vagrant, you should also use the [vagrant-windows](https://github.com/WinRb/vagrant-windows) plugin, which will ensure Vagrant works well with Windows. This will also allow Vagrant to use WinRM to communicate with the box. 

### Getting Started

Currently, this repo leverages trial versions of Windows 2008 R2 / 2012 / 2012 R2. 


Alternatively, if you have access to [MSDN](http://msdn.microsoft.com) or TechNet, you can download the ISO images Microsoft makes available there and place them in the `iso` directory. If you do so, you should update the relevent `.json` file, setting `iso_url` to `"./iso/<path to your iso>.iso"` and `iso_checksum` to `<the md5 of your iso>` after following these instructions:

1. Download the Windows Server 2008 R2 with Service Pack 1 (x64) - DVD (English) ISO (`en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`)
2. Verify that `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` has an MD5 hash of `8dcde01d0da526100869e2457aafb7ca` (Microsoft lists a SHA1 hash of `d3fd7bf85ee1d5bdd72de5b2c69a7b470733cd0a`, which is equivalent)
3. Clone this repo to a local directory
4. Move `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` to the `iso` directory
5. Run `packer build windows_2008_r2.json`

### Contributing

Pull requests welcomed. Please ensure you create your edits in a branch off of the `develop` branch, not the `master` branch.
