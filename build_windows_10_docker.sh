#!/bin/bash
# Windows 10 Insider 15031 + Docker 1.13.1
packer build --only=vmware-vmx --var source_path=~/.vagrant.d/boxes/windows_10_insider_15031/0/vmware_desktop/packer-vmware-iso.vmx windows_10_docker.json
