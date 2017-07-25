#!/bin/bash

# Microsoft Connect ISO
# packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/16237.1001.170701-0549.rs_prerelease_SERVER_ACORE_VOL_X64FRE_en-US.iso --var iso_checksum=674e275b0191bc1588c6b123eda372dd6c2d6c1b01ef63a70e86be2cc009b256 --var iso_checksum_type=sha256 --var autounattend=./tmp/2016_connect/Autounattend.xml windows_2016_insider.json
packer build --only=vmware-iso --var iso_url=~/packer_cache/insider/Windows_InsiderPreview_Server_2_16237.iso windows_2016_insider.json
