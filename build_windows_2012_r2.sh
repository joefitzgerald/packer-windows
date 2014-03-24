#!/bin/bash

if [ -f windows_2012_r2_virtualbox.box ]; then
  rm windows_2012_r2_virtualbox.box
fi

packer build -only=virtualbox-iso windows_2012_r2.json

if [ -f windows_2012_r2_virtualbox.box ]; then
  vagrant box remove windows_2012_r2
  vagrant box add windows_2012_r2 windows_2012_r2_virtualbox.box 
  #rm windows_2012_r2_virtualbox.box
fi
