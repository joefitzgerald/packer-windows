powershell.exe -Command "Install-WindowsFeature -Name Containers"

shutdown /r /t 5 /f /d p:4:1 /c "Reboot for Containters"
net stop winrm
net stop OpenSSHd

echo Sleeping while restart in progress
ping 127.0.0.1 -n 60 > nul
