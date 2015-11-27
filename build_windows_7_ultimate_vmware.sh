#!/bin/bash

if [ -f windows_7_ultimate_vmware.box ]; then
  rm windows_7_ultimate_vmware.box
fi

packer build -only=vmware-iso windows_7_ultimate.json

if [ -f windows_7_ultimate_vmware.box ]; then
  vagrant box add windows_7_ultimate windows_7_ultimate_vmware.box  --force
  #rm windows_7_ultimate_vmware.box
fi
