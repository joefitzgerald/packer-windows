
Start-Transcript -Path C:\provision.log -Append

Function SetupPhase1 {
  Cscript $env:WinDir\System32\SCregEdit.wsf /AU 1
  Net stop wuauserv
  Net start wuauserv

  Set-MpPreference -DisableRealtimeMonitoring $true

  New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "1" -Force

  Write-Host "Installing Chocolatey"
  iex (wget 'https://chocolatey.org/install.ps1' -UseBasicParsing)
  choco feature disable --name showDownloadProgress
  choco install -y git
  choco install -y packer
  choco install -y vagrant

  Write-Host "Installing Hyper-V"
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
  Install-WindowsFeature Hyper-V-Tools
  Install-WindowsFeature Hyper-V-PowerShell

#Write-Host Install all Windows Updates
#Get-Content C:\windows\system32\en-us\WUA_SearchDownloadInstall.vbs | ForEach-Object {
#  $_ -replace 'confirm = msgbox.*$', 'confirm = vbNo'
#} | Out-File $env:TEMP\WUA_SearchDownloadInstall.vbs
#"a`na" | cscript $env:TEMP\WUA_SearchDownloadInstall.vbs

  Write-Host "Rebooting"
  Restart-Computer
}

Function SetupPhase2 {

  Write-Host "Installing Vagrant plugins"
  vagrant plugin install vagrant-reload

  Write-Host "Adding NAT"
  New-VMSwitch -SwitchName "packer-hyperv-iso" -SwitchType Internal
  New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter -name "vEthernet (packer-hyperv-iso)").ifIndex
  New-NetNat -Name MyNATnetwork -InternalIPInterfaceAddressPrefix 192.168.0.0/24

  Write-Host "Adding DHCP scope"
  Install-WindowsFeature DHCP -IncludeManagementTools
  Add-DhcpServerv4Scope -Name "Internal" -StartRange 192.168.0.10 -EndRange 192.168.0.250 -SubnetMask 255.255.255.0 -Description "Internal Network"
  Set-DhcpServerv4OptionValue -ScopeID 192.168.0 -DNSServer 8.8.8.8 -Router 192.168.0.1

  Write-Host "Allow Packer http server"
  New-NetFirewallRule -DisplayName "Allow Packer" -Direction Inbound -Program "C:\ProgramData\chocolatey\lib\packer\tools\packer.exe" -RemoteAddress LocalSubnet -Action Allow

  Write-Host "Disabling autologon"
  New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon -PropertyType DWORD -Value "0" -Force

  Write-Host "Removing scheduled job"
  Unregister-ScheduledJob -Name NewServerSetupResume -Force
}

if (!(Test-Path c:\ProgramData\chocolatey)) {
  $pwd = ConvertTo-SecureString -String $Password -AsPlainText -Force
  $cred = New-Object System.Management.Automation.PSCredential($Username, $pwd)
  $AtStartup = New-JobTrigger -AtStartup
  Register-ScheduledJob -Name NewServerSetupResume `
                        -Credential $cred `
                        -Trigger $AtStartup `
                        -ScriptBlock { c:\provision.ps1 }
  SetupPhase1
} else {
  SetupPhase2
}
