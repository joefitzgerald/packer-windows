Set-ExecutionPolicy Bypass -scope Process
Invoke-WebRequest "https://get.docker.com/builds/Windows/x86_64/docker-1.12.1.zip" -OutFile "$env:TEMP\docker-1.12.1.zip" -UseBasicParsing
Expand-Archive -Path "$env:TEMP\docker-1.12.1.zip" -DestinationPath $env:ProgramFiles
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:ProgramFiles\docker\", [EnvironmentVariableTarget]::Machine)
. 'C:\Program Files\docker\dockerd' --register-service -H npipe:// -H 0.0.0.0:2375 -G docker
Start-Service Docker

Write-Host "Installing WindowsServerCore container image..."
& "C:\Program Files\docker\docker.exe" pull microsoft/windowsservercore:10.0.14300.1030
& "C:\Program Files\docker\docker.exe" tag microsoft/windowsservercore:10.0.14300.1030 microsoft/windowsservercore:latest

if ((get-windowsfeature Hyper-V | where installed).count) {
  Write-Host "Installing NanoServer container image..."
  & "C:\Program Files\docker\docker.exe" pull microsoft/nanoserver:10.0.14300.1030
  & "C:\Program Files\docker\docker.exe" tag microsoft/nanoserver:10.0.14300.1030 microsoft/nanoserver:latest
} else {
  Write-Host "Skipping NanoServer container image"
}
