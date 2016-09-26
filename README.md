# My Retina Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create boxes for Vagrant using Packer ([Website](https://www.packer.io)) ([Github](https://github.com/mitchellh/packer)).

This repo is a modified fork of the popular [joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows) repo.

Some of my enhancements are:

* Support of fullscreen Retina display on a MacBook Pro.
* WinRM, no more OpenSSH
* PowerShell attached to taskbar with new features enabled

### Packer Version

[Packer](https://github.com/mitchellh/packer/blob/master/CHANGELOG.md) `0.10.0` or greater is required.

### Windows Versions

The following Windows versions are known to work (built with VMware Fusion Pro 8.1.1):

 * Windows 10
 * Windows Server 2016
 * Windows Server 2016 with Hyper-V and Docker -> see [docker-windows-box](https://github.com/StefanScherer/docker-windows-box) for an use case

You may find other packer template files, but older versions of Windows doesn't work so nice with a Retina display.

### Windows Editions

All Windows Server versions are defaulted to the Server Standard edition. You can modify this by editing the Autounattend.xml file, changing the `ImageInstall`>`OSImage`>`InstallFrom`>`MetaData`>`Value` element (e.g. to Windows Server 2012 R2 SERVERDATACENTER).

### Product Keys

The `Autounattend.xml` files are configured to work correctly with trial ISOs (which will be downloaded and cached for you the first time you perform a `packer build`). If you would like to use retail or volume license ISOs, you need to update the `UserData`>`ProductKey` element as follows:

* Uncomment the `<Key>...</Key>` element
* Insert your product key into the `Key` element

If you are going to configure your VM as a KMS client, you can use the product keys at http://technet.microsoft.com/en-us/library/jj612867.aspx. These are the default values used in the `Key` element.

### Using existing ISOs
If you have already downloaded the ISOs or would like to override them, set these additional variables:
- iso_url - path to existing ISO
- iso_checksum - md5sum of existing ISO (if different)

```
packer build -var 'iso_url=./server2016.iso' .\windows_2016.json
```

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

### WinRM

These boxes use WinRM. There is no OpenSSH installed.

### Hyper-V Support
If you are running Windows 10, then you can also use these packerfiles to build a Hyper-V virtual machine:

This requires @taliesens [fork of Packer](https://github.com/mitchellh/packer/pull/2576) with Hyper-V support. The linked PR also has binaries available ex: https://dl.bintray.com/taliesins/Packer/Packer.1.0.0.104-HyperV.nupkg

Then run Packer:
```
packer build -var 'hyperv_switchname=Wifi' .\windows_2016.json
```
Be sure to set hyperv_switchname to an external Hyper-V switch.

I have the ISO already downloaded to save time, and only have Hyper-V installed on my laptop, so I run:
```
packer build --only hyperv-iso -var 'hyperv_switchname=Ethernet' -var 'iso_url=./server2016.iso' .\windows_2016_docker.json
```

You then can use this box with Vagrant to spin up a Hyper-V VM. Vagrant currently
needs some patches as well, see the script [install-vagrant.ps1](hyperv/scripts/install-vagrant.ps1)
how to patch Vagrant 1.8.4 to fix these issues.

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for
use with Vagrant 1.7.4+, which includes native support for Windows and uses
WinRM to communicate with the box.

Vagrant 1.8.4 does need some workarounds though:
- There is a bug in get_vm_status.ps1
- winrm-fs needs an update as well
See: https://github.com/PatrickLang/packer-windows/issues/1#issuecomment-230151622
These are fixed in 1.8.5, so upgrading is easiest.

Example Steps for Hyper-V:
```
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
vagrant init windows_2016_docker
vagrant up --provider hyperv
```


### Contributing

Pull requests welcomed, but normally should go to Joe's repo.
