#!/bin/bash
#packer build --only=vmware-iso windows_10.json

# Windows 10 Pro own license
#packer build --only=vmware-iso --var iso_url=~/packer_cache/my/Win10_1607_English_x64.iso --var iso_checksum=99fd8082a609997ae97a514dca22becf20420891 --var autounattend=./tmp/10_pro/Autounattend.xml windows_10.json

# Windows 10 Insider 16232
# packer build --only=vmware-iso --var iso_url=~/packer_cache/insider/Windows10_InsiderPreview_EnterpriseVL_x64_en-us_16232.iso --var iso_checksum=8e84a14b972a2d7643d347c57068b51e88e86ae5 windows_10_insider.json
# Windows 10 Insider 16241
packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/16241.1001.170708-1800.rs_prerelease_CLIENTENTERPRISE_VOL_X64FRE_en-US.iso --var iso_checksum=1ef19500cd45ba6bd013c4a0c3fd1633a2f830c6 windows_10_insider.json

# Windows 10 Enterprise MSDN
#packer build --only=vmware-iso --var iso_url=~/packer_cache/msdn/en_windows_10_enterprise_version_1607_updated_jan_2017_x64_dvd_9714415.iso --var iso_checksum=97164DD5C1C933BAEF89A4BDE93D544256134FE4 --var iso_checksum_type=sha1 --var autounattend=./tmp/10/Autounattend.xml windows_10.json
# packer build --only=vmware-iso --var iso_url=~/packer_cache/msdn/en_windows_10_enterprise_version_1703_updated_march_2017_x64_dvd_10189290.iso --var iso_checksum=77D5E7C91B5DBBEE410FB6C57CB944238BF7176A --var iso_checksum_type=sha1 --var autounattend=./tmp/10/Autounattend.xml windows_10.json

# Windows 10 Client 15031
#packer build --only=vmware-iso \
#  --var iso_url=~/connect/2017-02-08-windows10-15031-rs2/15031.0.170204-1546.RS2_RELEASE_CLIENTPRO-CORE_OEMRET_X64FRE_EN-US.ISO \
#  --var iso_checksum=d35a1bc67c4cf0226a4e7381752e81a0ab081356 \
#  --var autounattend=./tmp/10_pro_msdn/Autounattend.xml \
#  windows_10.json
