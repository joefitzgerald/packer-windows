# https://msdn.microsoft.com/de-de/virtualization/windowscontainers/quick_start/quick_start_windows_10
New-Item -Type Directory -Path 'C:\Program Files\docker\'
Invoke-WebRequest https://aka.ms/tp5/b/dockerd -OutFile $env:ProgramFiles\docker\dockerd.exe
Invoke-WebRequest https://aka.ms/tp5/b/docker -OutFile $env:ProgramFiles\docker\docker.exe
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
. 'C:\Program Files\docker\dockerd' --register-service -H npipe:// -H 0.0.0.0:2375
Start-Service Docker
