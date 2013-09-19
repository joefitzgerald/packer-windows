#!/bin/sh
set -x

if [ "$PACKER_BUILDER_TYPE" != "virtualbox" ]; then
  echo "not building virtualbox, skipping"
  exit
fi

# 7zip will allow us to extract a file from an ISO
wget http://downloads.sourceforge.net/sevenzip/7z920-x64.msi
msiexec /qb /i 7z920-x64.msi

# There needs to be Oracle CA (Certificate Authority) certificates installed in order
# to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\\oracle-cert.cer

mkdir /home/vagrant/virtualbox
chown -R vagrant /home/vagrant/virtualbox

# Extract and install
/cygdrive/c/Program\ Files/7-Zip/7z.exe x -y C:\\cygwin\\VBoxGuestAdditions*.iso -ovirtualbox
cmd.exe /c .\\virtualbox\\VBoxWindowsAdditions.exe /S

rm -rf /home/vagrant/VBoxGuestAdditions.iso
rm -rf /home/vagrant/virtualbox

msiexec /qb /x 7z920-x64.msi
rm -rf 7z920-x64.msi

#cmd /c shutdown.exe /r /t 0 /d p:4:1 /c "Vagrant reboot for VBoxWindowsAdditions"
sleep 1
