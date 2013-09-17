#!/bin/sh
set -x

wget http://www.opscode.com/chef/install.msi -O chef-client-latest.msi
msiexec /qb /i chef-client-latest.msi
rm chef-client-latest.msi

sleep 1
