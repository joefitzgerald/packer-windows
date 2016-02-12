# Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create boxes for
Vagrant using Packer ([Website](http://www.packer.io))
([Github](http://github.com/mitchellh/packer)).

This repo began by borrowing bits from the VeeWee Windows templates (https://github.com/jedi4ever/veewee/tree/master/templates). Modifications were
made to work with Packer and the VMware Fusion / VirtualBox providers for Packer
and Vagrant.

### Quick Start

This repository contains the required meta-data and scripts for you to
successfully build a new Windows VM from an ISO. Before beginning lets ensure
you have the required tools installed on your workstation:

1. [VirtualBox 5.0.12+](https://www.virtualbox.org/wiki/Downloads) (or VMWare)
2. [Golang runtime](https://golang.org/dl/)
3. [Packer 0.8.6+](https://www.packer.io/downloads.html)
4. [Inductor latest](https://github.com/joefitzgerald/inductor)

Both Packer and Inductor should be available in your PATH, if not go fix that
now.

Lets actually run a build which involves two command line tools: inductor
and packer. Inductor is a tool which works with the metadata in this repository
to build the proper packer.json, Autounattend.xml, and Vagrantfile for Packer.
These files feed into Packer to produce a fully functioning Windows Vagrant box.

1. Clone this repository to your workstation
2. cd to packer-windows
3. Run inductor with the OS you want, e.g. `inductor windows10`
4. Run packer: `packer build -only=virtualbox-iso packer.json`

Once Packer completes you should have a new Vagrant box file in the current
directory which you can then `vagrant add` and `vagrant up`.

### Windows Versions

The following Windows versions are known to work (built with VMware Fusion 6.0.4
and VirtualBox 5.0.12):

 * Windows 2012 R2
 * Windows 2012 R2 Core
 * Windows 2012
 * Windows 2008 R2
 * Windows 2008 R2 Core
 * Windows 10
 * Windows 8.1
 * Windows 7

To see which Windows versions are available you can run inductor from the root
of this repo directory with no arguments, i.e. `inductor`.

### Windows Editions

All Windows Server versions are defaulted to the Server Standard edition. You
can modify this by editing the osregistry.json file, changing the
`windows_image_name` value (e.g. to Windows Server 2012 R2 SERVERDATACENTER).

### Product Keys

The Autounattned.xml.tpl is configured to work correctly with trial ISOs (which
will be automatically downloaded and cached for you the first time you perform
a `packer build`). If you would like to use retail or volume license ISOs, there
are a few ways to do that.

1. Create your own OS registry.json file providing the proper ISO URL, checksum,
etc. This is currently the recommended approach.
2. Use the inductor command line `--productkey` flag.
3. Create your own Autounattend.xml.tpl and hardcode the values.

If you are going to configure your VM as a KMS client, you can use the product
keys at http://technet.microsoft.com/en-us/library/jj612867.aspx.

### Windows Updates

The scripts in this repo will install all Windows updates – by default – during
Windows Setup. This is a _very_ time consuming process, depending on the age of
the OS and the quantity of updates released since the last service pack. For
example, its not uncommon for Windows7 to take 6-8 hours whereas Windows 10
takes less than an hour.

You might want to do yourself a favor during development and disable this
functionality by specifying the inductor `--skipwindowsupdates` command line
flag. Doing so will give you hours back in your day, which is a good thing.

### OpenSSH / WinRM

We now default to using the WinRM communicator in Packer. You may
override this behavior and revert back to using the SSH communicator along with
OpenSSH by specifying the `--ssh` inductor command line flag.

It's worth mentioning that many Chef cookbooks will not work properly through
Cygwin's SSH environment on Windows. Specifically, packages that need access to
environment-specific configurations such as the `PATH` variable, will fail. This
includes packages that use the Windows installer, `msiexec.exe`.

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for
use with Vagrant 1.6.2+, which includes native support for Windows and uses
WinRM to communicate with the box.

### Getting Started

Trial versions of Windows 2008 R2 / 2012 / 2012 R2 are used by default. These
images can be used for 180 days without activation.

Alternatively – if you have access to [MSDN](http://msdn.microsoft.com) or
[TechNet](http://technet.microsoft.com/) – you can download retail or volume
license ISO images and place them in the `iso` directory. If you do, you need
to edit the osregistry.json file with `iso_url` (e.g. `./iso/<path to your iso>.iso`)
and `iso_checksum` (e.g. `<the md5 of your iso>`) to the Packer command. For
example, to use the Windows 2008 R2 (With SP1) retail ISO:

1. Download the Windows Server 2008 R2 with Service Pack 1 (x64) - DVD (English) ISO (`en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`)
2. Verify that `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` has an
MD5 hash of `8dcde01d0da526100869e2457aafb7ca` (Microsoft lists a SHA1 hash of
`d3fd7bf85ee1d5bdd72de5b2c69a7b470733cd0a`, which is equivalent).
3. Clone this repo to a local directory
4. Move `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` to the `iso` directory
5. Add thw following entry to the osregistry.json:

```json
"windows2008r2sp1": {
  "iso_url": "./iso/en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso",
  "iso_checksum_type": "sha1",
  "iso_checksum": "8dcde01d0da526100869e2457aafb7ca",
  "windows_image_name": "Windows Server 2008 R2 SERVERSTANDARD",
  "virtualbox_guest_os_type": "Windows2008_64",
  "vmware_guest_os_type": "windows7srv-64"
},
```

Execute inductor to product the updated Packer input files and execute Packer:

```
inductor windows2008r2sp1
packer build packer.json
```

### Contributing

Pull requests welcomed.

### Acknowledgements

[CloudBees](http://www.cloudbees.com) is providing a hosted [Jenkins](http://jenkins-ci.org/) master through their CloudBees FOSS program. We also use their [On-Premise Executor](https://developer.cloudbees.com/bin/view/DEV/On-Premise+Executors) feature to connect a physical [Mac Mini Server](http://www.apple.com/mac-mini/server/) running VMware Fusion.

![Powered By CloudBees](http://www.cloudbees.com/sites/default/files/Button-Powered-by-CB.png "Powered By CloudBees")![Built On DEV@Cloud](http://www.cloudbees.com/sites/default/files/Button-Built-on-CB-1.png "Built On DEV@Cloud")
