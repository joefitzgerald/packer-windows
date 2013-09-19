#!/bin/sh
set -x

wget --no-check-certificate http://pm.puppetlabs.com/puppet-enterprise/3.0.1/puppet-enterprise-3.0.1.msi -O puppet.msi
msiexec /qn /i puppet.msi
rm -rf puppet.msi
cmd.exe /c setx /m PATH "%path%;C:\\Program Files (x86)\\Puppet Labs\\Puppet Enterprise\\bin"

sleep 1
