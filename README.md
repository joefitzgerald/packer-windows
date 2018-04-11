# My Retina Windows Templates for Packer

[![Build status](https://ci.appveyor.com/api/projects/status/76pea1oexae5ca05?svg=true)](https://ci.appveyor.com/project/StefanScherer/packer-windows)

### Introduction

This repository contains Windows templates that can be used to create boxes for
Vagrant using Packer ([Website](https://www.packer.io))
([Github](https://github.com/mitchellh/packer)).

This repo is a modified fork of the popular
[joefitzgerald/packer-windows](https://github.com/joefitzgerald/packer-windows)
repo.

Some of my enhancements are:

* Support of fullscreen Retina display on a MacBook Pro.
* WinRM, no more OpenSSH
* PowerShell attached to taskbar in desktop editions

### Packer Version

[Packer](https://github.com/mitchellh/packer/blob/master/CHANGELOG.md) `1.1.3` is recommended.

### Windows Versions

The following Windows versions are known to work (built with VMware Fusion Pro
10.1.1):

* Windows 10
  * Windows 10 1709
  * Windows 10 Insider
* Windows Server 2016 Desktop
* Windows Server 2019 Desktop (Insider Preview)
* Windows Server Core
  * Windows Server 2016 without and with Docker
  * Windows Server 1709 without and with Docker
  * Windows Server InsiderPreview Semi-Annual without and with Docker
  * Windows Server 2019 Core(Insider Preview)

You may find other packer template files, but older versions of Windows doesn't
work so nice with a Retina display.

### Windows Editions

All Windows Server versions are defaulted to the Server Standard edition. You
can modify this by editing the Autounattend.xml file, changing the
`ImageInstall`>`OSImage`>`InstallFrom`>`MetaData`>`Value` element (e.g. to
Windows Server 2012 R2 SERVERDATACENTER).

To retrieve the correct ImageName from an ISO file use the following two commands.

```
PS C:\> Mount-DiskImage -ImagePath C:\iso\Windows_InsiderPreview_Server_2_16237.iso
PS C:\> Get-WindowsImage -ImagePath e:\sources\install.wim

ImageIndex       : 1
ImageName        : Windows Server 2016 SERVERSTANDARDACORE
ImageDescription : Windows Server 2016 SERVERSTANDARDACORE
ImageSize        : 7,341,507,794 bytes

ImageIndex       : 2
ImageName        : Windows Server 2016 SERVERDATACENTERACORE
ImageDescription : Windows Server 2016 SERVERDATACENTERACORE
ImageSize        : 7,373,846,520 bytes
```

### Product Keys

The `Autounattend.xml` files are configured to work correctly with trial ISOs
(which will be downloaded and cached for you the first time you perform a
`packer build`). If you would like to use retail or volume license ISOs, you
need to update the `UserData`>`ProductKey` element as follows:

* Uncomment the `<Key>...</Key>` element
* Insert your product key into the `Key` element

If you are going to configure your VM as a KMS client, you can use the product
keys at http://technet.microsoft.com/en-us/library/jj612867.aspx. These are the
default values used in the `Key` element.

### Using existing ISOs

If you have already downloaded the ISOs or would like to override them, set
these additional variables:

* iso_url - path to existing ISO
* iso_checksum - md5sum of existing ISO (if different)

```
packer build -var 'iso_url=./server2016.iso' .\windows_2016.json
```

### Windows Updates

The scripts in this repo will install all Windows updates – by default – during
Windows Setup. This is a _very_ time consuming process, depending on the age of
the OS and the quantity of updates released since the last service pack. You
might want to do yourself a favor during development and disable this
functionality, by commenting out the `WITH WINDOWS UPDATES` section and
uncommenting the `WITHOUT WINDOWS UPDATES` section in `Autounattend.xml`:

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

If you are running Windows 10, Windows Server 2016 or later, then you can also use these packerfiles to build
a Hyper-V virtual machine. I have the ISO already downloaded to save time, and
only have Hyper-V installed on my laptop, so I run:

```
packer build --only hyperv-iso -var 'hyperv_switchname=Ethernet' -var 'iso_url=./server2016.iso' .\windows_2016_docker.json
```

You then can use this box with Vagrant to spin up a Hyper-V VM.

#### Generation 2 VMs

Some of these images use Hyper-V "Generation 2" VMs to enable the latest features and faster booting. However, an extra manual step is needed to put the needed files into ISOs because Gen2 VMs don't support virtual floppy disks.

* `windows_server_insider.json`
* `windows_server_insider_docker.json`
* `windows_10_insider.json`

Before running `packer build`, be sure to run `./make_unattend_iso.ps1` first. Otherwise the build will fail on a missing ISO file

```none
hyperv-iso output will be in this color.

1 error(s) occurred:

* Secondary Dvd image does not exist: CreateFile ./iso/windows_server_insider_unattend.iso: The system cannot find the file specified.
```

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for use
with Vagrant 1.7.4+, but the latest ersion is always recommended.

Example Steps for Hyper-V:

```
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
vagrant init windows_2016_docker
vagrant up --provider hyperv
```

### Contributing

Pull requests welcomed, but normally should go to Joe's repo.
