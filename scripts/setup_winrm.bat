cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm quickconfig -transport:http
cmd.exe /c winrm set winrm/config @{MaxTimeoutms="1800000"}
cmd.exe /c winrm set winrm/config/winrs @{MaxConcurrentUsers="100"}
cmd.exe /c winrm set winrm/config/winrs @{MaxProcessesPerShell="100"}
cmd.exe /c winrm set winrm/config/winrs @{MaxMemoryPerShellMB="1024"}
cmd.exe /c winrm set winrm/config/winrs @{MaxShellsPerUser="100"}
cmd.exe /c winrm set winrm/config/service @{AllowUnencrypted="true"}
cmd.exe /c winrm set winrm/config/client @{AllowUnencrypted="true"}
cmd.exe /c winrm set winrm/config/service/auth @{Basic="true"}
cmd.exe /c winrm set winrm/config/client/auth @{Basic="true"}
cmd.exe /c winrm set winrm/config/listener?Address=*+Transport=HTTP @{Port="5985"}

reg add "HKLM\SYSTEM\CurrentControlSet\services\WinRM" /v DelayedAutostart /t REG_DWORD /d 0 /f
