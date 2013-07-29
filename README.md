# Windows Templates for Packer

### Introduction

This repository contains Windows templates that can be used to create boxes for Vagrant using Packer ([Website](packer.io)) ([Github](http://github.com/mitchellh/packer)).

This repo began by borrowing bits from the VeeWee Windows templates (https://github.com/jedi4ever/veewee/tree/master/templates). Modifications were made to work with Packer and the VMware Fusion provider for Packer and Vagrant.

### Getting Started

This repository assumes that you have access to [MSDN](http://msdn.microsoft.com) and can download the ISO images Microsoft makes available there.

Currently, this repo expects you to do a little heavy lifting to get the Windows ISO required to build boxes.

1. Download the Windows Server 2008 R2 with Service Pack 1 (x64) - DVD (English) ISO (`en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso`)
2. Verify that `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` has an MD5 hash of `8dcde01d0da526100869e2457aafb7ca` (Microsoft lists a SHA1 hash of `d3fd7bf85ee1d5bdd72de5b2c69a7b470733cd0a`, which is equivalent)
3. Clone this repo to a local directory
4. Create a directory named `iso` in the root of the repo
5. Move `en_windows_server_2008_r2_with_sp1_x64_dvd_617601.iso` to the `iso` directory
6. Run `packer build windows.json`

### Contributing

Pull requests welcomed. I plan to include other variants of Windows 2008 R2 and Windows 2012 next.