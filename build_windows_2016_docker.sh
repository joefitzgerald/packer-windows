#!/bin/bash
packer build --only=vmware-iso --var iso_url=~/packer_cache/14300.1000.160324-1723.RS1_RELEASE_SVC_SERVER_OEMRET_X64FRE_EN-US.ISO windows_2016_docker.json
packer build --only=virtualbox-iso --var iso_url=~/packer_cache/14300.1000.160324-1723.RS1_RELEASE_SVC_SERVER_OEMRET_X64FRE_EN-US.ISO windows_2016_docker.json
