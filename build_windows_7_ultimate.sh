#!/bin/bash

if [ -f windows_7_ultimate_virtualbox.box ]; then
  rm windows_7_ultimate_virtualbox.box
fi

packer build -only=virtualbox-iso windows_7_ultimate.json

if [ -f windows_7_ultimate_virtualbox.box ]; then
  vagrant box remove windows_7_ultimate -f
  vagrant box add windows_7_ultimate windows_7_ultimate_virtualbox.box 
  #rm windows_7_ultimate_virtualbox.box
fi
