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
 * Windows Server 2016 TP5
 * Windows Server 2016 TP5 with Hyper-V and Docker -> see [docker-windows-box](https://github.com/StefanScherer/docker-windows-box) for an use case

You may find other packer template files, but older versions of Windows doesn't work so nice with a Retina display.

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

### WinRM

These boxes use WinRM. There is no OpenSSH installed.

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for
use with Vagrant 1.7.4+, which includes native support for Windows and uses
WinRM to communicate with the box.

For Vagrant 1.7.4 you should update some Ruby gems with

```
vagrant plugin install winrm
vagrant plugin install winrm-fs
```

Vagrant 1.8+ will have these gems already preinstalled.

### Contributing

Pull requests welcomed, but normally should go to Joe's repo.
