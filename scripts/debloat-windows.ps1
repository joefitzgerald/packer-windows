Write-Host Downloading debloat zip
$url="https://github.com/StefanScherer/Debloat-Windows-10/archive/master.zip"
(New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\debloat.zip")
Expand-Archive -Path $env:TEMP\debloat.zip -DestinationPath $env:TEMP -Force

Write-Host Disable scheduled tasks
. $env:TEMP\Debloat-Windows-10-master\utils\disable-scheduled-tasks.ps1
Write-Host Block telemetry
. $env:TEMP\Debloat-Windows-10-master\scripts\block-telemetry.ps1
Write-Host Disable services
. $env:TEMP\Debloat-Windows-10-master\scripts\disable-services.ps1
Write-host Disable Windows Defender
. $env:TEMP\Debloat-Windows-10-master\scripts\disable-windows-defender.ps1
Uninstall-WindowsFeature Windows-Defender-Features
Write-host Optimize Windows Update
. $env:TEMP\Debloat-Windows-10-master\scripts\optimize-windows-update.ps1
Write-host Disable Windows Update
Set-Service wuauserv -StartupType Disabled
Write-Host Remove OneDrive
. $env:TEMP\Debloat-Windows-10-master\scripts\remove-onedrive.ps1
