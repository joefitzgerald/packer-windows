#"Remove" | Out-File C:\Users\vagrant\Desktop\delete-me-to-continue.txt

#while (Test-Path C:\Users\vagrant\Desktop\delete-me-to-continue.txt) {
#  Start-Sleep 1
#}

Write-Host "Downloading nanoserver image"
docker import http://172.16.63.1:8080/CBaseOs_rs3_release_16278.1000.170825-1441_amd64fre_NanoServer_en-us.tar.gz microsoft/nanoserver-insider:latest
Write-Host "Downloading windowsservercore image"
docker import http://172.16.63.1:8080/CBaseOs_rs3_release_16278.1000.170825-1441_amd64fre_ServerDatacenterCore_en-us.tar.gz microsoft/windowsservercore-insider:latest
docker images
