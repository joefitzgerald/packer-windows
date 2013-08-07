#!/bin/sh
set -x

# Create the home directory
mkdir -p /home/vagrant
chown vagrant /home/vagrant
cd /home/vagrant

# Install ssh certificates
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh
cd ..

# Install rpm,apt-get like code for cygwin
# http://superuser.com/questions/40545/upgrading-and-installing-packages-through-the-cygwin-command-line
wget http://apt-cyg.googlecode.com/svn/trunk/apt-cyg
chmod +x apt-cyg
mv apt-cyg /usr/local/bin/

cat <<'EOF' > /bin/sudo
#!/usr/bin/bash
exec "$@"
EOF
chmod 755 /bin/sudo

# 7zip will allow us to extract a file from an ISO
wget http://downloads.sourceforge.net/sevenzip/7z920-x64.msi
msiexec /qb /i 7z920-x64.msi

#Rather than do the manual install of ruby and chef, just use the opscode msi
wget http://www.opscode.com/chef/install.msi -O chef-client-latest.msi
msiexec /qb /i chef-client-latest.msi
rm chef-client-latest.msi

# Download VMware Tools For Windows
mkdir /home/vagrant/vmware
chown -R vagrant /home/vagrant/vmware
cd /home/vagrant/vmware
wget http://softwareupdate.vmware.com/cds/vmw-desktop/ws/9.0.2/1031769/windows/packages/tools-windows-9.2.3.exe.tar
tar -xvf /home/vagrant/vmware/tools-windows-9.2.3.exe.tar
rm /home/vagrant/vmware/tools-windows-9.2.3.exe.tar
chown -R vagrant /home/vagrant/vmware

# Install the VMware Tools
/home/vagrant/vmware/tools-windows-9.2.3.exe
rm /home/vagrant/vmware/tools-windows-9.2.3.exe
/cygdrive/c/Program\ Files/7-Zip/7z.exe x C:\\Program\ Files\ \(x86\)\\VMware\\tools-windows\\windows.iso
rm C:\\Program\ Files\ \(x86\)\\VMware\\tools-windows\\windows.iso
chown -R vagrant /home/vagrant/vmware
cmd.exe /c "C:\\cygwin\\home\\vagrant\\vmware\\setup.exe /S /v\"/qn REBOOT=R\""
sleep 1