#!/bin/bash

if [ -f windows_7_vcloud.box ]; then
  rm windows_7_vcloud.box
fi

packer build -only=vmware-iso windows_7_vcloud.json

