# Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create machine images with Packer ([Website](http://www.packer.io)) ([Github](http://github.com/mitchellh/packer)).

### Packer Version

[Packer](https://github.com/mitchellh/packer) `0.8.6` or greater is required.

### Windows Versions

The following Windows versions are known to work (built with VMware Fusion 8.0.1 and VirtualBox 5.0.6):

 * Windows 2012 R2
 * Windows 2012 R2 Core
 * Windows 2012
 * Windows 2008 R2
 * Windows 2008 R2 Core
 * Windows 10
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
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\enable-winrm.ps1</CommandLine>
    <Description>Enable WinRM</Description>
    <Order>99</Order>
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
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\win-updates.ps1</CommandLine>
    <Description>Install Windows Updates</Description>
    <Order>100</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
-->
<!-- END WITH WINDOWS UPDATES -->
```

Doing so will give you hours back in your day, which is a good thing.

### Post Processors

By default, the compress post-processor is used to create an archive of your VM. You can then use this with the [virtualbox-ovf](https://www.packer.io/docs/builders/virtualbox-ovf.html) or [vmware-vmx](https://www.packer.io/docs/builders/vmware-vmx.html) builders to further iterate on your image. This approach is recommended, particularly if you apply all Windows updates in your initial image. It will save you tens or hundreds of hours as you iterate on your project.

If you would like to switch back to the old approach of generating .box files for use with Vagrant, just replace the provisioners section with:

```json
"post-processors": [
  {
    "type": "vagrant",
    "keep_input_artifact": false,
    "output": "windows_2012_r2_{{.Provider}}.box",
    "vagrantfile_template": "vagrantfile-windows_2012_r2.template"
  }
]
```

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for
use with Vagrant 1.6.2+, which includes native support for Windows and uses
WinRM to communicate with the box.

### Getting Started

Trial versions of Windows 2008 R2 / 2012 / 2012 R2 / 7 / 8.1 / 10 are used by default. These images can be used for 180 days without activation.

Alternatively – if you have access to [MSDN](http://msdn.microsoft.com) or [TechNet](http://technet.microsoft.com/) – you can download retail or volume license ISO images and place them in the `iso` directory. If you do, you should supply appropriate values for `iso_url` (e.g. `./iso/<path to your iso>.iso`) and `iso_checksum` (e.g. `<the md5 of your iso>`) to the Packer command. For example, to use the Windows 2008 R2 (With SP1) retail ISO:

1. Download the Windows Server 2008 R2 with Service Pack 1 (x64) - DVD (English) ISO (`en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`)
2. Verify that `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` has an MD5 hash of `8dcde01d0da526100869e2457aafb7ca` (Microsoft lists a SHA1 hash of `d3fd7bf85ee1d5bdd72de5b2c69a7b470733cd0a`, which is equivalent)
3. Clone this repo to a local directory
4. Move `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` to the `iso` directory
5. Run:

    ```
    packer build \
        -var iso_url=./iso/en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso \
        -var iso_checksum=8dcde01d0da526100869e2457aafb7ca windows_2008_r2.json
    ```

### Variables

The Packer templates support the following variables:

| Name                | Description                                                      |
|:--------------------|:-----------------------------------------------------------------|
| `iso_url`           | Path or URL to ISO file                                          |
| `iso_checksum`      | Checksum (see also `iso_checksum_type`) of the ISO file          |
| `iso_checksum_type` | The checksum algorithm to use (out of those supported by Packer) |
| `autounattend`      | Path to the Autounattend.xml file                                |

### Contributing

Pull requests welcomed.
