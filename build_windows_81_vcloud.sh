#!/bin/bash

if [ -f windows_81_vcloud.box ]; then
  rm windows_81_vcloud.box
fi

packer build -only=vmware-iso windows_81_vcloud.json

if [ -f windows_81_vcloud.box ]; then
  vagrant box remove windows_81
  vagrant box add windows_81 windows_81_vcloud.box 
  #rm windows_81_vcloud.box
fi
