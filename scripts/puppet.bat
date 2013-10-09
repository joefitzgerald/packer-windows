
if not exist "C:\Windows\Temp\puppet.msi" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.puppetlabs.com/windows/puppet-3.3.0.msi', 'C:\Windows\Temp\puppet.msi')" <NUL
)

:: http://docs.puppetlabs.com/pe/latest/install_windows.html
msiexec /qn /i C:\Windows\Temp\puppet.msi /log C:\Windows\Temp\puppet.log
cmd /c setx /m PATH "%path%;C:\\Program Files (x86)\\Puppet Labs\\Puppet\\bin"

powershell -Command "Start-Sleep 1" <NUL
