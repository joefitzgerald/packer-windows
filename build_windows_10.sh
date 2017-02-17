#!/bin/bash
#packer build --only=vmware-iso windows_10.json

# Windows 10 Pro own license
#packer build --only=vmware-iso --var iso_url=~/packer_cache/my/Win10_1607_English_x64.iso --var iso_checksum=99fd8082a609997ae97a514dca22becf20420891 --var autounattend=./tmp/10_pro/Autounattend.xml windows_10.json

# Windows 10 Insider 15025
#packer build --only=vmware-iso --var iso_url=~/packer_cache/Windows10_InsiderPreview_EnterpriseVL_x64_en-us_15025.iso windows_10_insider.json

# Windows 10 Enterprise MSDN
#packer build --only=vmware-iso --var iso_url=~/packer_cache/msdn/en_windows_10_enterprise_version_1607_updated_jan_2017_x64_dvd_9714415.iso --var iso_checksum=97164DD5C1C933BAEF89A4BDE93D544256134FE4 --var iso_checksum_type=sha1 --var autounattend=./tmp/10/Autounattend.xml windows_10.json

# Windows 10 Client 15031
packer build --only=vmware-iso \
  --var iso_url=~/connect/2017-02-08-windows10-15031-rs2/15031.0.170204-1546.RS2_RELEASE_CLIENTPRO-CORE_OEMRET_X64FRE_EN-US.ISO \
  --var iso_checksum=d35a1bc67c4cf0226a4e7381752e81a0ab081356 \
  --var autounattend=./tmp/10_pro_msdn/Autounattend.xml \
  windows_10.json
