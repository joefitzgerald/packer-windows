# Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create boxes for Vagrant using Packer ([Website](http://www.packer.io)) ([Github](http://github.com/mitchellh/packer)).

This repo began by borrowing bits from the VeeWee Windows templates (https://github.com/jedi4ever/veewee/tree/master/templates). Modifications were made to work with Packer and the VMware Fusion / VirtualBox providers for Packer and Vagrant.

### Packer Version

[Packer](https://github.com/mitchellh/packer/blob/master/CHANGELOG.md) `0.5.1` or greater is required.

### Windows Versions

The following Windows versions are known to work (built with VMware Fusion 6.0.4 and VirtualBox 4.3.12):
<!--
|                              | Develop                                                                                                                                                                                                               | Master                                                                                                                                                                                                             |
| ---------------------------- |:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Windows 2008 R2 SP1 Standard | [![Build Status - Windows 2008 R2 SP1 Standard on Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-develop-2008-r2)](https://packer.ci.cloudbees.com/job/packer-windows-develop-2008-r2/) | [![Build Status - Windows 2008 R2 SP1 Standard on Master](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-master-2008-r2)](https://packer.ci.cloudbees.com/job/packer-windows-master-2008-r2/) |
| Windows 2012 Standard        | [![Build Status - Windows 2012 Standard on Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-develop-2012)](https://packer.ci.cloudbees.com/job/packer-windows-develop-2012/)              | [![Build Status - Windows 2012 Standard on Master](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-master-2012)](https://packer.ci.cloudbees.com/job/packer-windows-master-2012/)              |
| Windows 2012 R2 Standard     | [![Build Status - Windows 2012 R2 Standard on Develop](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-develop-2012-r2)](https://packer.ci.cloudbees.com/job/packer-windows-develop-2012-r2/)     | [![Build Status - Windows 2012 R2 Standard on Master](https://packer.ci.cloudbees.com/buildStatus/icon?job=packer-windows-master-2012-r2)](https://packer.ci.cloudbees.com/job/packer-windows-master-2012-r2/)     |
-->

 * Windows 2012 R2
 * Windows 2012 R2 Core
 * Windows 2012
 * Windows 2008 R2
 * Windows 2008 R2 Core
 * Windows 8.1
 * Windows 7

### Windows Editions

All Windows Server versions are defaulted to the Server Standard edition. You can modify this by editing the Autounattend.xml file, changing the `ImageInstall`>`OSImage`>`InstallFrom`>`MetaData`>`Value` element (e.g. to Windows Server 2012 R2 SERVERDATACENTER).

### Product Keys

The `Autounattend.xml` files are configured to work correctly with trial ISOs (which will be downloaded and cached for you the first time you perform a `packer build`). If you would like to use retail or volume license ISOs, you need to update the `UserData`>`ProductKey` element as follows:

* Uncomment the `<Key>...</Key>` element
* Insert your product key into the `Key` element

If you are going to configure your VM as a KMS client, you can use the product keys at http://technet.microsoft.com/en-us/library/jj612867.aspx. These are the default values used in the `Key` element.

### Windows Updates

The scripts in this repo will install all Windows updates – by default – during Windows Setup. This is a _very_ time consuming process, depending on the age of the OS and the quantity of updates released since the last service pack. You might want to do yourself a favor during development and disable this functionality, by commenting out the `WITH WINDOWS UPDATES` section and uncommenting the `WITHOUT WINDOWS UPDATES` section in `Autounattend.xml`:

```xml
<!-- WITHOUT WINDOWS UPDATES -->
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\openssh.ps1 -AutoStart</CommandLine>
    <Description>Install OpenSSH</Description>
    <Order>99</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
<!-- END WITHOUT WINDOWS UPDATES -->
<!-- WITH WINDOWS UPDATES -->
<!--
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c a:\microsoft-updates.bat</CommandLine>
    <Order>98</Order>
    <Description>Enable Microsoft Updates</Description>
</SynchronousCommand>
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\openssh.ps1</CommandLine>
    <Description>Install OpenSSH</Description>
    <Order>99</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\win-updates.ps1</CommandLine>
    <Description>Install Windows Updates</Description>
    <Order>100</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
-->
<!-- END WITH WINDOWS UPDATES -->
```

Doing so will give you hours back in your day, which is a good thing.

### OpenSSH / WinRM

Currently, [Packer](http://packer.io) has a single communitator that uses SSH. This means we need an SSH server installed on Windows - which is not optimal as we could use WinRM to communicate with the Windows VM. In the short term, everything works well with SSH; in the medium term, work is underway on a WinRM communicator for Packer.

If you have serious objections to OpenSSH being installed, you can always add another stage to your build pipeline:

* Build a base box using Packer
* Create a Vagrantfile, use the base box from Packer, connect to the VM via WinRM (using the [vagrant-windows](https://github.com/WinRb/vagrant-windows) plugin) and disable the 'sshd' service or uninstall OpenSSH completely
* Perform a Vagrant run and output a .box file

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for
use with Vagrant 1.6.2+, which includes native support for Windows and uses
WinRM to communicate with the box.

### Getting Started

Trial versions of Windows 2008 R2 / 2012 / 2012 R2 are used by default. These images can be used for 180 days without activation.

Alternatively – if you have access to [MSDN](http://msdn.microsoft.com) or [TechNet](http://technet.microsoft.com/) – you can download retail or volume license ISO images and place them in the `iso` directory. If you do, you should update the relevent `.json` file, setting `iso_url` to `./iso/<path to your iso>.iso` and `iso_checksum` to `<the md5 of your iso>`. For example, to use the Windows 2008 R2 (With SP1) retail ISO:

1. Download the Windows Server 2008 R2 with Service Pack 1 (x64) - DVD (English) ISO (`en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`)
2. Verify that `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` has an MD5 hash of `8dcde01d0da526100869e2457aafb7ca` (Microsoft lists a SHA1 hash of `d3fd7bf85ee1d5bdd72de5b2c69a7b470733cd0a`, which is equivalent)
3. Clone this repo to a local directory
4. Move `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` to the `iso` directory
5. Update `windows_2008_r2.json`, setting `iso_url` to `./iso/en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`
6. Update `windows_2008_r2.json`, setting `iso_checksum` to `8dcde01d0da526100869e2457aafb7ca`
7. Run `packer build windows_2008_r2.json`

### Contributing

Pull requests welcomed. Please ensure you create your edits in a branch off of the `develop` branch, not the `master` branch.

### Acknowledgements

[CloudBees](http://www.cloudbees.com) is providing a hosted [Jenkins](http://jenkins-ci.org/) master through their CloudBees FOSS program. We also use their [On-Premise Executor](https://developer.cloudbees.com/bin/view/DEV/On-Premise+Executors) feature to connect a physical [Mac Mini Server](http://www.apple.com/mac-mini/server/) running VMware Fusion.

![Powered By CloudBees](http://www.cloudbees.com/sites/default/files/Button-Powered-by-CB.png "Powered By CloudBees")![Built On DEV@Cloud](http://www.cloudbees.com/sites/default/files/Button-Built-on-CB-1.png "Built On DEV@Cloud")
