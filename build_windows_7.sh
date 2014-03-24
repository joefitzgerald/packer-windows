#!/bin/bash

if [ -f windows_7_virtualbox.box ]; then
  rm windows_7_virtualbox.box
fi

packer build -only=virtualbox-iso windows_7.json

if [ -f windows_7_virtualbox.box ]; then
  vagrant box remove windows_7
  vagrant box add windows_7 windows_7_virtualbox.box 
  #rm windows_7_virtualbox.box
fi
