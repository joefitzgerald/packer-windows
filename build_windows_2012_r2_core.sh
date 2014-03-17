#!/bin/bash

if [ -f windows_2012_r2_core_virtualbox.box ]; then
  rm windows_2012_r2_core_virtualbox.box
fi

packer build -only=virtualbox-iso windows_2012_r2_core.json

if [ -f windows_2012_r2_core_virtualbox.box ]; then
  vagrant box remove windows_2012_r2_core
  vagrant box add windows_2012_r2_core windows_2012_r2_core_virtualbox.box 
  #rm windows_2012_r2_core_virtualbox.box
fi
