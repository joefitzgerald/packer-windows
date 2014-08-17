#!/bin/bash

if [ -f windows_7_ultimate_virtualbox.box ]; then
  rm windows_7_ultimate_virtualbox.box
fi

packer build -only=virtualbox-iso windows_7_ultimate.json

if [ -f windows_7_ultimate_virtualbox.box ]; then
  vagrant box add windows_7_ultimate windows_7_ultimate_virtualbox.box --force
  #rm windows_7_ultimate_virtualbox.box
fi
