Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Install-WindowsFeature Hyper-V-Tools
Install-WindowsFeature Hyper-V-PowerShell
