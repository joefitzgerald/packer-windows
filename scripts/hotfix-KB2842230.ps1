
$winver = [System.Environment]::OSVersion.Version
# Windows 8 / Windows 2012 require KB2842230 hotfix
# The Windows Remote Management (WinRM) service does not use the customized value of the MaxMemoryPerShellMB quota.
# Instead, the WinRM service uses the default value, which is 150 MB. 
if ($winver.Major -eq 6 -and ($winver.Minor -eq 2 -or $winver.Minor -eq 3)) {

  #$HotfixUrl = "http://hotfixv4.microsoft.com/Windows%208%20RTM/nosp/Fix452763/9200/free/463941_intl_x64_zip.exe"
  $HotfixMsu = "A:\Windows8-RT-KB2842230-x64.msu"
  if (Test-Path $HotfixMsu) {
    Write-Host "Executing KB2842230 hotfix"
    start-process -NoNewWindow -FilePath "wusa.exe" -ArgumentList "$HotfixMsu /quiet /norestart"

    # Damn thing exists immediately.
    Start-Sleep -s 60
    Write-Host "A reboot will be required before Chocolatey can be used via Puppet"
  }
}
