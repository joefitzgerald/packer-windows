#!/bin/bash

if [ -f windows_2008_r2_vmware.box ]; then
  rm windows_2008_r2_vmware.box
fi

packer build -only=vmware-iso windows_2008_r2.json

if [ -f windows_2008_r2_vmware.box ]; then
  vagrant box add windows_2008_r2 windows_2008_r2_vmware.box --force
  #rm windows_2008_r2_vmware.box
fi
