#!/bin/bash
#packer build --only=vmware-iso --var iso_url=~/packer_cache/Win10_1511_English_x64.iso --var iso_checksum=875ec108288b9f581e5d8099cf0edb79f0f3e483 windows_10.json

# my own license
# packer build --only=vmware-iso --var iso_url=~/packer_cache/Win10_1511_English_x64.iso --var iso_checksum=875ec108288b9f581e5d8099cf0edb79f0f3e483 --var autounattend=./tmp/10/Autounattend.xml windows_10.json

# latest Insider ISO
packer build --only=vmware-iso --var iso_url=~/packer_cache/Windows10_InsiderPreview_Client_x64_en-us_14295.1000.iso --var iso_checksum=ee3b237cbfff293c2c9e5b036a0250b39c3f79ae --var autounattend=./tmp/10/Autounattend.xml windows_10.json
