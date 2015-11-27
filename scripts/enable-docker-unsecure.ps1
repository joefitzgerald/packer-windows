Write-Host "WARNING: DO NOT USE DOCKER IN PRODUCTION WITHOUT TLS"
Write-Host "Enabling Docker unsecure port 2375"

if (!(Get-NetFirewallRule | where {$_.Name -eq "DockerUnsecure2375"})) {
    New-NetFirewallRule -Name "DockerUnsecure2375" -DisplayName "Docker unsecure on TCP/2375" -Protocol tcp -LocalPort 2375 -Action Allow -Enabled True
}

Write-Host "Enabling Docker to listen on unsecure port 2375"
cp C:\programdata\docker\runDockerDaemon.cmd C:\programdata\docker\runDockerDaemon.cmd.bak
cat C:\programdata\docker\runDockerDaemon.cmd.bak | %{$_ -replace '^docker daemon -D -b "Virtual Switch"$','docker daemon -D -b "Virtual Switch" -H 0.0.0.0:2375'} | Set-Content C:\programdata\docker\runDockerDaemon.cmd

Write-Host "Restarting Docker"
Stop-Service docker
Start-Service docker
