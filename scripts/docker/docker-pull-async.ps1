function DockerPull {
  Param ([string]$image)

  Write-Host Installing $image ...
  $j = Start-Job -ScriptBlock { docker pull $image }
  while ( $j.JobStateInfo.state -ne "Completed" ) {
    Write-Host $j.JobStateInfo.state
    Start-Sleep 10
  }

  $results = Receive-Job -Job $j
  $results
}

DockerPull microsoft/windowsservercore
DockerPull microsoft/nanoserver
