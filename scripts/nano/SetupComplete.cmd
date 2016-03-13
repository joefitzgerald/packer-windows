:: Copyright 2015, Matt Wrock

net stop winrm

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\WSMAN\Service /v allow_unencrypted /t REG_DWORD /d 1 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\WSMAN\Service /v auth_basic /t REG_DWORD /d 1 /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\WSMAN\Client /v auth_basic /t REG_DWORD /d 1 /f

netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes

net user vagrant vagrant /ADD /FULLNAME:"vagrant" /ACTIVE:YES /PASSWORDCHG:NO /EXPIRES:NEVER
net localgroup "Administrators" vagrant /add

cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command . c:\windows\setup\scripts\cleanup.ps1 > c:\windows\setup\scripts\cleanup.txt

net start winrm
