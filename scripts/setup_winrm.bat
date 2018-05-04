powershell.exe -Command "Enable-PSRemoting -Force"

cmd.exe /c winrm set winrm/config @{MaxTimeoutms="1800000"}
cmd.exe /c winrm set winrm/config/winrs @{MaxConcurrentUsers="100"}
cmd.exe /c winrm set winrm/config/winrs @{MaxProcessesPerShell="100"}
cmd.exe /c winrm set winrm/config/winrs @{MaxMemoryPerShellMB="1024"}
cmd.exe /c winrm set winrm/config/winrs @{MaxShellsPerUser="100"}
cmd.exe /c winrm set winrm/config/service @{AllowUnencrypted="true"}
cmd.exe /c winrm set winrm/config/service/auth @{Basic="true"}

REG add "HKLM\SYSTEM\CurrentControlSet\services\WinRM" /v DelayedAutostart /t REG_DWORD /d 0 /f
