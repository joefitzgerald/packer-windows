#!/bin/bash
#packer build --only=vmware-iso windows_10.json

# Windows 10 Pro own license
#packer build --only=vmware-iso --var iso_url=~/packer_cache/my/Win10_1607_English_x64.iso --var iso_checksum=99fd8082a609997ae97a514dca22becf20420891 --var autounattend=./tmp/10_pro/Autounattend.xml windows_10.json

# Windows 10 Insider 15063
#packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/15063.0.170317-1834.RS2_RELEASE_CLIENTENTERPRISE_VOL_X64FRE_EN-US.ISO --var iso_checksum=77d5e7c91b5dbbee410fb6c57cb944238bf7176a windows_10_insider.json

# Windows 10 Enterprise MSDN
#packer build --only=vmware-iso --var iso_url=~/packer_cache/msdn/en_windows_10_enterprise_version_1607_updated_jan_2017_x64_dvd_9714415.iso --var iso_checksum=97164DD5C1C933BAEF89A4BDE93D544256134FE4 --var iso_checksum_type=sha1 --var autounattend=./tmp/10/Autounattend.xml windows_10.json
packer build --only=vmware-iso --var iso_url=~/packer_cache/msdn/en_windows_10_enterprise_version_1703_updated_march_2017_x64_dvd_10189290.iso --var iso_checksum=77D5E7C91B5DBBEE410FB6C57CB944238BF7176A --var iso_checksum_type=sha1 --var autounattend=./tmp/10/Autounattend.xml windows_10.json

# Windows 10 Client 15031
#packer build --only=vmware-iso \
#  --var iso_url=~/connect/2017-02-08-windows10-15031-rs2/15031.0.170204-1546.RS2_RELEASE_CLIENTPRO-CORE_OEMRET_X64FRE_EN-US.ISO \
#  --var iso_checksum=d35a1bc67c4cf0226a4e7381752e81a0ab081356 \
#  --var autounattend=./tmp/10_pro_msdn/Autounattend.xml \
#  windows_10.json
