#!/bin/bash

if [ -f windows_81_virtualbox.box ]; then
  rm windows_81_virtualbox.box
fi

packer build -only=virtualbox-iso windows_81.json

if [ -f windows_81_virtualbox.box ]; then
  vagrant box remove windows_81
  vagrant box add windows_81 windows_81_virtualbox.box 
  #rm windows_81_virtualbox.box
fi
