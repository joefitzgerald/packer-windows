# https://msdn.microsoft.com/de-de/virtualization/windowscontainers/quick_start/quick_start_windows_10
Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
sc.exe config winrm start= delayed-auto
