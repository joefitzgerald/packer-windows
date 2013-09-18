if [ "$PACKER_BUILDER_TYPE" -ne "vmware" ]; then
  echo "not building vmware, skipping"
  exit
fi

# 7zip will allow us to extract a file from an ISO
wget http://downloads.sourceforge.net/sevenzip/7z920-x64.msi
msiexec /qb /i 7z920-x64.msi

# Download VMware Tools For Windows
mkdir /home/vagrant/vmware
chown -R vagrant /home/vagrant/vmware
cd /home/vagrant/vmware
wget http://softwareupdate.vmware.com/cds/vmw-desktop/ws/10.0.0/1295980/windows/packages/tools-windows-9.6.0.exe.tar
tar -xvf /home/vagrant/vmware/tools-windows-9.6.0.exe.tar
rm -rf /home/vagrant/vmware/tools-windows-9.6.0.exe.tar
chown -R vagrant /home/vagrant/vmware

# Install the VMware Tools
/home/vagrant/vmware/tools-windows-9.6.0.exe
rm -rf /home/vagrant/vmware/tools-windows-9.6.0.exe
/cygdrive/c/Program\ Files/7-Zip/7z.exe x C:\\Program\ Files\ \(x86\)\\VMware\\tools-windows\\windows.iso
rm -rf C:\\Program\ Files\ \(x86\)\\VMware\\tools-windows\\windows.iso
chown -R vagrant /home/vagrant/vmware
cmd.exe /c "C:\\cygwin\\home\\vagrant\\vmware\\setup.exe /S /v\"/qn REBOOT=R\""
rm -rf /home/vagrant/vmware
cd /home/vagrant
msiexec /qb /x 7z920-x64.msi
rm -rf 7z920-x64.msi

sleep 1
