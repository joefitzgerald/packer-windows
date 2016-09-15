Set-ExecutionPolicy Bypass -scope Process
Invoke-WebRequest "https://master.dockerproject.org/windows/amd64/docker-1.13.0-dev.zip" -OutFile "$env:TEMP\docker-1.13.0-dev.zip" -UseBasicParsing
Expand-Archive -Path "$env:TEMP\docker-1.13.0-dev.zip" -DestinationPath $env:ProgramFiles
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:ProgramFiles\docker\", [EnvironmentVariableTarget]::Machine)
. 'C:\Program Files\docker\dockerd' --register-service -H npipe:// -H 0.0.0.0:2375 -G docker
Start-Service Docker

Write-Host "Installing WindowsServerCore container image..."
& "C:\Program Files\docker\docker.exe" pull microsoft/windowsservercore:latest

if ((get-windowsfeature Hyper-V | where installed).count) {
  Write-Host "Installing NanoServer container image..."
  & "C:\Program Files\docker\docker.exe" pull microsoft/nanoserver:latest

} else {
  Write-Host "Skipping NanoServer container image"
}
