#!/bin/bash

# Microsoft Connect ISO
# packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/16251.1000.170721-1512.rs_prerelease_SERVER_ACORE_VOL_X64FRE_en-US.iso --var iso_checksum=303073849054d28806600af6212fccdeabff5590190664a038b2693c17d537df --var iso_checksum_type=sha256 --var autounattend=./tmp/2016_connect/Autounattend.xml windows_2016_insider.json
# packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/16257.1000.170728-1630.rs_prerelease_SERVER_ACORE_VOL_X64FRE_en-US.iso --var iso_checksum=b988201b8019a272d67f5f6737f2180bfedcc2cf5b065aab7fbceb43eaa7d995 --var iso_checksum_type=sha256 --var autounattend=./tmp/2016_connect/Autounattend.xml windows_2016_insider.json
packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/16275.1000.170822-1423.rs3_release_SERVER_ACORE_VOL_x64FRE_en-us.iso --var iso_checksum=a0f7aa63991c086bdbcaafb5871005204eb90373020144b403d3231b52ca1d52 --var iso_checksum_type=sha256 --var autounattend=./tmp/2016_connect/Autounattend.xml windows_2016_insider.json
# Windows Insider ISO
#packer build --only=vmware-iso --var iso_url=~/packer_cache/insider/Windows_InsiderPreview_Server_2_16237.iso windows_2016_insider.json
