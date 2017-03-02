#!/bin/bash
# Windows 10 Insider 15031 + Docker 17.03.0-ce
packer build --only=vmware-vmx --var source_path=~/.vagrant.d/boxes/windows_10/0/vmware_desktop/windows_10.vmx windows_10_docker.json
