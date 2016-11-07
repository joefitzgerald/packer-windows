Write-Host Downloading debloat zip
$url="https://github.com/StefanScherer/Debloat-Windows-10/archive/master.zip"
(New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\debloat.zip")
Expand-Archive -Path $env:TEMP\debloat.zip -DestinationPath $env:TEMP -Force

Write-Host Debloating
. $env:TEMP\Debloat-Windows-10-master\utils\disable-scheduled-tasks.ps1
. $env:TEMP\Debloat-Windows-10-master\scripts\block-telemetry.ps1
. $env:TEMP\Debloat-Windows-10-master\scripts\disable-services.ps1
. $env:TEMP\Debloat-Windows-10-master\scripts\disable-windows-defender.ps1
. $env:TEMP\Debloat-Windows-10-master\scripts\optimize-windows-update.ps1
. $env:TEMP\Debloat-Windows-10-master\scripts\remove-onedrive.ps1
