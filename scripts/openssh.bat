
:: setup openssh
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.mls-software.com/files/setupssh-6.3p1-1(x64).exe', 'C:\Windows\Temp\openssh.exe')"
cmd /c C:\Windows\temp\openssh.exe /S /port=22 /privsep=1 /password=D@rj33l1ng

:: ensure vagrant can log in
mkdir "C:\Users\vagrant\.ssh"
cmd /c C:\Windows\System32\icacls.exe "C:\Users\vagrant" /grant vagrant:(OI)(CI)F
cmd /c C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\bin" /grant vagrant:(OI)RX
cmd /c C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\usr\sbin" /grant vagrant:(OI)RX
powershell -Command "(Get-Content 'C:\Program Files\OpenSSH\etc\passwd') | Foreach-Object { $_ -replace '/home/(\w+)', '/cygdrive/c/Users/$1' } | Set-Content 'C:\Program Files\OpenSSH\etc\passwd'"

:: fix opensshd to not be strict
powershell -Command "(Get-Content 'C:\Program Files\OpenSSH\etc\sshd_config') -replace 'StrictModes yes', 'StrictModes no' | Set-Content 'C:\Program Files\OpenSSH\etc\sshd_config'"
powershell -Command "(Get-Content 'C:\Program Files\OpenSSH\etc\sshd_config') -replace '#PubkeyAuthentication yes', 'PubkeyAuthentication yes' | Set-Content 'C:\Program Files\OpenSSH\etc\sshd_config'"
powershell -Command "(Get-Content 'C:\Program Files\OpenSSH\etc\sshd_config') -replace '#PermitUserEnvironment no', 'PermitUserEnvironment yes' | Set-Content 'C:\Program Files\OpenSSH\etc\sshd_config'"

:: use Windows\Temp as /tmp location
rd /S /Q "C:\Program Files\OpenSSH\tmp"
cmd /c ""C:\Program Files\OpenSSH\bin\junction.exe" /accepteula "C:\Program Files\OpenSSH\tmp" C:\Windows\Temp"
cmd /c C:\Windows\System32\icacls.exe "C:\Windows\Temp" /grant vagrant:(OI)(CI)F
powershell -Command "Add-Content C:\Users\vagrant\.ssh\environment "TEMP=C:\Windows\Temp""

:: record the path for use by provisioners
<nul set /p ".=%PATH%" > C:\Windows\Temp\PATH

if "%1" neq "START" (
  cmd /c net stop opensshd
)

:: configure firewall
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow service=OpenSSHd enable=yes
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow program="C:\Program Files\OpenSSH\usr\sbin\sshd.exe" enable=yes
netsh advfirewall firewall add rule name="ssh" dir=in action=allow protocol=TCP localport=22
