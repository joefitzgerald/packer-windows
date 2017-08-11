#!/bin/bash
# packer build --only=vmware-iso --var iso_url=~/packer_cache/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO windows_2016_docker.json

# MSDN ISO
packer build --only=vmware-iso --var iso_url=~/packer_cache/msdn/en_windows_server_2016_x64_dvd_9718492.iso --var iso_checksum=F185197AF68FAE4F0E06510A4579FC511BA27616 --var iso_checksum_type=sha1 --var autounattend=./tmp/2016/Autounattend.xml windows_2016_core.json
