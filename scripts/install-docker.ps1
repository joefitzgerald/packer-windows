Sleep 2

# https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/inplace_setup
wget -uri https://aka.ms/tp4/Install-ContainerHost -OutFile C:\Install-ContainerHost.ps1

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

  & schtasks /Delete /F /TN InstallContainerHost
  & schtasks /Create /TN InstallContainerHost /XML $XmlFile
  & schtasks /Run /TN InstallContainerHost

  Write-Host "Waiting until Scheduled Task InstallContainerHost task is no longer running"
  do {
    Start-Sleep -Seconds 5
  } while ( (& schtasks /query /tn InstallContainerHost | Select-String -Pattern "InstallContainerHost" -SimpleMatch) -like "*Running*")

  if ((& schtasks /query /tn InstallContainerHost | Select-String -Pattern "InstallContainerHost" -SimpleMatch) -like "*Could not start*") {
    Write-Error "Scheduled Task InstallContainerHost could not start!"
  } else {
    Write-Host "Scheduled Task InstallContainerHost '$commandline' finished"
  }

  cat C:\progress.txt

  $halt = 0
  if ($halt) {
    Write-Host "Delete me to continue" | Out-File -FilePath $env:USERPROFILE\Desktop\deleteme.txt
    Write-Host "Pausing until $env:USERPROFILE\Desktop\deleteme.txt gets deleted"
    do {
      Start-Sleep -Seconds 5
    } while (Test-Path $env:USERPROFILE\Desktop\deleteme.txt)
  }
  & schtasks /Delete /F /TN InstallContainerHost
}

if (Test-Path a:\oracle-cert.cer) {
  Write-Host "Skip installation of Hyper-V on VirtualBox Container Host"
  $installOptions = ""
} else {
  Write-Host "Add installation of Hyper-V on Container Host"
  $installOptions = "-HyperV"
}

# Download latest nightly build of docker engine
$wantNightlyDocker = $false
if ($wantNightlyDocker) {
  $ExeFile = "C:\Users\vagrant\Downloads\docker.exe"
  wget -o $ExeFile https://master.dockerproject.org/windows/amd64/docker.exe
  Run-Interactive -commandline "C:\Install-ContainerHost.ps1 $installOptions -DockerPath $ExeFile | Tee-Object -FilePath C:\progress.txt"
} else {
  Run-Interactive -commandline "C:\Install-ContainerHost.ps1 $installOptions | Tee-Object -FilePath C:\progress.txt"
}

# https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/manage_docker
