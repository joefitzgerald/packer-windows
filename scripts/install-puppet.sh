#!/bin/sh
set -x

wget --no-check-certificate http://pm.puppetlabs.com/puppet-enterprise/2.7.2/puppet-enterprise-2.7.2.msi
msiexec /qn /i puppet-enterprise-2.7.2.msi
cmd.exe /c setx /m PATH "%path%;C:\\Program Files (x86)\\Puppet Labs\\Puppet Enterprise\\bin"

sleep 1
