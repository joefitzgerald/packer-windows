#!/bin/bash

if [ -f windows_2008_r2_vcloud.box ]; then
  rm windows_2008_r2_vcloud.box
fi

packer build -only=vmware-iso windows_2008_r2_vcloud.json

