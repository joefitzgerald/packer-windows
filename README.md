# Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create boxes for Vagrant using Packer ([Website](packer.io)) ([Github](http://github.com/mitchellh/packer)).

This repo began by borrowing bits from the VeeWee Windows templates (https://github.com/jedi4ever/veewee/tree/master/templates). Modifications were made to work with Packer and the VMware Fusion provider for Packer and Vagrant.

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

### Getting Started

Currently, this repo leverages trial versions of Windows 2008 R2 / 2012 / 2012 R2. 


Alternatively, if you have access to [MSDN](http://msdn.microsoft.com) or TechNet, you can download the ISO images Microsoft makes available there and place them in the `iso` directory. If you do so, you should update the relevent `.json` file, setting `iso_url` to `"./iso/<path to your iso>.iso"` and `iso_checksum` to `<the md5 of your iso>` after following these instructions:

1. Download the Windows Server 2008 R2 with Service Pack 1 (x64) - DVD (English) ISO (`en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`)
2. Verify that `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` has an MD5 hash of `8dcde01d0da526100869e2457aafb7ca` (Microsoft lists a SHA1 hash of `d3fd7bf85ee1d5bdd72de5b2c69a7b470733cd0a`, which is equivalent)
3. Clone this repo to a local directory
4. Create a directory named `iso` in the root of the repo
5. Move `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` to the `iso` directory
6. Run `packer build windows_2008_r2.json`

### Contributing

Pull requests welcomed. Please ensure you create your edits in a branch off of the `develop` branch, not the `master` branch.
