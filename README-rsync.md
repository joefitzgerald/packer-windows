# How to enable RSync for Windows Templates

## Introduction

This document explains how to install RSync into the Windows boxes to be able to use Vagrant's synced folder type `rsync`. Read the [Vagrant Docs](https://docs.vagrantup.com/v2/synced-folders/rsync.html) for more details and the additional vagrant commands.

## Prerequisites

### SSH

To use `rsync` in the Windows boxes you also will need that SSH is installed and enabled. At the time of writing OpenSSH will always be installed to make the packer build work. This is part of the `Autounattend.xml` answer files.

In the future SSH might disappear from default installation as packer will be able to communicate through WinRM with the Windows box. For rsync you then have to add the `scripts/openssh.ps1` again to have OpenSSH up and running.

## Installation

To install `rsync` in the Windows boxes you have to add the `./scripts/rsync.bat` script to the packer template's shell provisioner scripts as shown in this example:

```json
  "provisioners": [
    {
      "type": "shell",
      "remote_path": "/tmp/script.bat",
      "execute_command": "{{.Vars}} cmd /c C:/Windows/Temp/script.bat",
      "scripts": [
        "./scripts/vm-guest-tools.bat",
        "./scripts/chef.bat",
        "./scripts/vagrant-ssh.bat",
        "./scripts/compile-dotnet-assemblies.bat",
        "./scripts/rsync.bat",
        "./scripts/compact.bat"
      ]
    },
```

The script also creates a symlink so that the folder `/vagrant` could be used in the Vagrantfile to sync files to `C:\vagrant`. So the example from the Vagrant documentation works without any changes.

## Enable RSync in a Vagrantfile

The following is an example of using RSync to sync a folder into a Windows box. Please notice that we have to forward the SSH port as it will not be forwarded automatically at the moment.
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "windows_2012_r2"

  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"

  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  end
end
```

If you want to sync into another directory of the Windows box, use the Cygwin path prefix `/cygdrive/c` as shown in this example:

```ruby
  config.vm.synced_folder '.', "/cygdrive/c/vagrant-rsync",
    type: "rsync",
    rsync__auto: "true",
    rsync__exclude: [".git/",".vagrant/"],
    id: "vagrant"
```
