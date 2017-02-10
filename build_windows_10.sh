#!/bin/bash
#packer build --only=vmware-iso windows_10.json

# my own license
#packer build --only=vmware-iso --var iso_url=~/packer_cache/Win10_1607_English_x64.iso --var iso_checksum=99fd8082a609997ae97a514dca22becf20420891 --var autounattend=./tmp/10/Autounattend.xml windows_10.json

# Windows 10 Insider 15002
# packer build --only=vmware-iso --var iso_url=~/packer_cache/Windows10_InsiderPreview_EnterpriseVL_x64_en-us_15002.iso --var iso_checksum=86fdf5c4061edde17a6aece0590225e6880b39ee --var autounattend=./tmp/10_insider/Autounattend.xml windows_10.json

# Windows 10 Insider 15025
packer build --only=vmware-iso --var iso_url=~/packer_cache/Windows10_InsiderPreview_EnterpriseVL_x64_en-us_15025.iso windows_10_insider.json
