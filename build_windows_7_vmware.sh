#!/bin/bash

if [ -f windows_7_vmware.box ]; then
  rm windows_7_vmware.box
fi

packer build -only=vmware-iso windows_7.json

if [ -f windows_7_vmware.box ]; then
  vagrant box add windows_7 windows_7_vmware.box --force
  #rm windows_7_vmware.box
fi
