Start-Transcript -Path C:\provision.log

function Get-HostToIP($hostname) {
  $result = [system.Net.Dns]::GetHostByName($hostname)
  $result.AddressList | ForEach-Object {$_.IPAddressToString }
}

Write-Host "provision.ps1"
Write-Host "HostName = $($HostName)"

Write-Host Windows Updates to manual
Cscript $env:WinDir\System32\SCregEdit.wsf /AU 1
Net stop wuauserv
Net start wuauserv

Write-Host Disable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $true

Write-Host Do not open Server Manager at logon
New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "1" -Force

Write-Host Install Chocolatey
iex (wget 'https://chocolatey.org/install.ps1' -UseBasicParsing)

Write-Host Install editors
choco install -y atom

Write-Host Install Git
choco install -y git

Write-Host Install Packer
choco install -y packer

Write-Host Install Vagrant
choco install -y vagrant

Write-Host Install Docker
choco install -y docker

Write-Host Install HyperV
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Install-WindowsFeature Hyper-V-Tools
Install-WindowsFeature Hyper-V-PowerShell

Write-Host Disable autologon
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon -PropertyType DWORD -Value "0" -Force

Write-Host Install all Windows Updates
Get-Content C:\windows\system32\en-us\WUA_SearchDownloadInstall.vbs | ForEach-Object {
  $_ -replace 'confirm = msgbox.*$', 'confirm = vbNo'
} | Out-File $env:TEMP\WUA_SearchDownloadInstall.vbs
"a`na" | cscript $env:TEMP\WUA_SearchDownloadInstall.vbs

Write-Host Cleaning up
Remove-Item C:\provision.ps1

Write-Host Restarting computer
Restart-Computer
