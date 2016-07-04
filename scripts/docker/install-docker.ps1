# https://msdn.microsoft.com/de-de/virtualization/windowscontainers/quick_start/quick_start_windows_10
Set-ExecutionPolicy Bypass -scope Process
New-Item -Type Directory -Path 'C:\Program Files\docker\'
Invoke-WebRequest https://aka.ms/tp5/b/dockerd -OutFile $env:ProgramFiles\docker\dockerd.exe
Invoke-WebRequest https://aka.ms/tp5/b/docker -OutFile $env:ProgramFiles\docker\docker.exe
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
. 'C:\Program Files\docker\dockerd' --register-service -H npipe:// -H 0.0.0.0:2375 -G docker
Install-PackageProvider ContainerImage -Force

# create a Task Scheduler task which is also able to run in battery mode due
# to host notebooks working in battery mode.

function Run-Interactive {
  param( [string] $commandline)

  $xml = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2014-03-27T13:53:05</Date>
    <Author>vagrant</Author>
  </RegistrationInfo>
  <Triggers>
    <TimeTrigger>
      <StartBoundary>2014-03-27T00:00:00</StartBoundary>
      <Enabled>true</Enabled>
    </TimeTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>vagrant</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>LeastPrivilege</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>P3D</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>-Command $commandline ; sleep 15</Arguments>
    </Exec>
  </Actions>
</Task>
"@

  $XmlFile = $env:Temp + "\InstallContainerHost.xml"
  Write-Host "Write Task '$commandline' to $XmlFile"
  $xml | Out-File $XmlFile

  & schtasks /Delete /F /TN InstallContainerImage
  & schtasks /Create /TN InstallContainerImage /XML $XmlFile
  & schtasks /Run /TN InstallContainerImage

  Write-Host "Waiting until Scheduled Task InstallContainerHost task is no longer running"
  do {
    Start-Sleep -Seconds 5
  } while ( (& schtasks /query /TN InstallContainerImage | Select-String -Pattern "InstallContainerImage" -SimpleMatch) -like "*Running*")

  if ((& schtasks /query /TN InstallContainerImage | Select-String -Pattern "InstallContainerImage" -SimpleMatch) -like "*Could not start*") {
    Write-Error "Scheduled Task InstallContainerHost could not start!"
  } else {
    Write-Host "Scheduled Task InstallContainerHost '$commandline' finished"
  }

  & schtasks /Delete /F /TN InstallContainerImage
}

Write-Host "Installing WindowsServerCore container image..."
Run-Interactive -commandline "Install-ContainerImage -Name WindowsServerCore"

if ((get-windowsfeature Hyper-V | where installed).count)
  Write-Host "Installing NanoServer container image..."
  Run-Interactive -commandline "Install-ContainerImage -Name NanoServer"
} else {
  Write-Host "Skipping NanoServer container image"
}

Start-Service Docker
