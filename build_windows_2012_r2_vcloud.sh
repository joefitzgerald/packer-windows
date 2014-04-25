#!/bin/bash
export PATH=/Users/stefan/go/src/github.com/mitchellh/packer/pkg/darwin_amd64:$PATH
export PATH=/Applications/VMware\ Fusion.app/Contents/Library/VMware\ OVF\ Tool/:$PATH
packer --version
ovftool --version

packer build -only=vmware-iso windows_2012_r2_vcloud.json
