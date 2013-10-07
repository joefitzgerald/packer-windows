
if not exist "C:\Windows\Temp\puppet.msi" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://pm.puppetlabs.com/puppet-enterprise/3.0.1/puppet-enterprise-3.0.1.msi', 'C:\Windows\Temp\puppet.msi')"
)
msiexec /qn /i C:\Windows\Temp\puppet.msi
cmd /c setx /m PATH "%path%;C:\\Program Files (x86)\\Puppet Labs\\Puppet Enterprise\\bin"

powershell -Command "Start-Sleep 1"