
:: setup openssh
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.mls-software.com/files/setupssh-6.2p2-1-v1(x64).exe', 'C:\Windows\Temp\openssh-6.2.exe')"
cmd /c C:\Windows\temp\openssh-6.2.exe /S /port=22 /privsep=1 /password=D@rj33l1ng

:: ensure vagrant can log in
mkdir "C:\Users\vagrant\.ssh"
cmd /c C:\Windows\System32\icacls.exe "C:\Users\vagrant" /grant vagrant:(OI)(CI)F
cmd /c C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\bin" /grant vagrant:(OI)RX
cmd /c C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\usr\sbin" /grant vagrant:(OI)RX
powershell -Command "(Get-Content 'C:\Program Files\OpenSSH\etc\passwd') | Foreach-Object { $_ -replace '/home/(\w+)', '/cygdrive/c/Users/$1' } | Set-Content 'C:\Program Files\OpenSSH\etc\passwd'"

:: use Windows\Temp as /tmp location
rd /S /Q "C:\Program Files\OpenSSH\tmp"
cmd /c ""C:\Program Files\OpenSSH\bin\junction.exe" /accepteula "C:\Program Files\OpenSSH\tmp" C:\Windows\Temp"
cmd /c C:\Windows\System32\icacls.exe "C:\Windows\Temp" /grant vagrant:(OI)(CI)F

:: record the path for use by provisioners
<nul set /p ".=%PATH%" > C:\Windows\Temp\PATH

if "%1" neq "START" (
  cmd /c net stop opensshd
)

:: configure firewall
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow service=OpenSSHd enable=yes
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow program="C:\Program Files\OpenSSH\usr\sbin\sshd.exe" enable=yes
netsh advfirewall firewall add rule name="ssh" dir=in action=allow protocol=TCP localport=22
