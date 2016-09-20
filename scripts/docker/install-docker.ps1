Set-ExecutionPolicy Bypass -scope Process
New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"
wget -outfile $env:TEMP\docker-1.12.1.zip https://get.docker.com/builds/Windows/x86_64/docker-1.12.1.zip
Expand-Archive -Path $env:TEMP\docker-1.12.1.zip -DestinationPath $env:TEMP -Force
copy $env:TEMP\docker\*.exe $env:ProgramFiles\docker
Remove-Item $env:TEMP\docker-1.12.1.zip
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker

Start-Service Docker

Write-Host "Installing WindowsServerCore docker image..."
docker pull microsoft/windowsservercore:10.0.14300.1030
docker pull microsoft/windowsservercore

if ((get-windowsfeature Hyper-V | where installed).count) {
  Write-Host "Installing NanoServer docker image..."
  docker pull microsoft/nanoserver:10.0.14300.1030
  docker pull microsoft/nanoserver
} else {
  Write-Host "Skipping NanoServer docker image"
}
