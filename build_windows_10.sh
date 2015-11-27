#!/bin/bash
#packer build --only=vmware-iso --var iso_url=~/packer_cache/Win10_1511_English_x64.iso --var iso_checksum=875ec108288b9f581e5d8099cf0edb79f0f3e483 --var autounattend=./tmp/10/Autounattend.xml --var product_key=$(pass windows_7_prof_license) windows_10.json
packer build --only=vmware-iso --var iso_url=~/packer_cache/Win10_1511_English_x64.iso --var iso_checksum=875ec108288b9f581e5d8099cf0edb79f0f3e483 --var autounattend=./tmp/10/Autounattend.xml windows_10.json
