#!/bin/bash

# Microsoft Connect ISO
# packer build --only=vmware-iso --var iso_url=~/packer_cache/connect/17035.1000.171103-1616.rs_prerelease_SERVER_ACORE_VOL_x64FRE_en-us.iso --var iso_checksum=dd412bd5c7d29fa5166a10f4cb36dacf7fcb605a5b8e8a6e8fa87e13aed6851d --var iso_checksum_type=sha256 --var autounattend=./tmp/2016_connect/Autounattend.xml  windows_server_insider_docker.json

# Windows Insider ISO
PACKER_LOG=debug packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/packer_cache/insider/Windows_InsiderPreview_Server_17074.iso \
  windows_server_insider_docker.json
