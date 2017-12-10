#!/bin/bash
# MSDN 1709 ISO
packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/packer_cache/msdn/en_windows_server_version_1709_x64_dvd_100090904.iso \
  --var iso_checksum=ca1108d5be2c091bfb57e8f3db3be1e8baa9c32802131f7a6e43e63f7b596591 \
  --var iso_checksum_type=sha256 \
  --var autounattend=./tmp/1709/Autounattend.xml \
  windows_server_1709_docker.json
#  --var disk_type_id=3 \
#  --var disk_size=30720 \
