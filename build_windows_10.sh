#!/bin/bash
#packer build --only=vmware-iso windows_10.json

# my own license
packer build --only=vmware-iso --var iso_url=~/packer_cache/Win10_1607_English_x64.iso --var iso_checksum=99fd8082a609997ae97a514dca22becf20420891 --var autounattend=./tmp/10/Autounattend.xml windows_10.json
