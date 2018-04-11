#!/bin/bash

packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/packer_cache/insider/Windows_InsiderPreview_Server_vNext_en-us_17639.iso \
  windows_2019.json
