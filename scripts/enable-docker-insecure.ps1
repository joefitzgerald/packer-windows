Write-Host "WARNING: DO NOT USE DOCKER IN PRODUCTION WITHOUT TLS"
Write-Host "Enabling Docker insecure port 2375"

if (!(Get-NetFirewallRule | where {$_.Name -eq "Dockerinsecure2375"})) {
    New-NetFirewallRule -Name "Dockerinsecure2375" -DisplayName "Docker insecure on TCP/2375" -Protocol tcp -LocalPort 2375 -Action Allow -Enabled True
}

Write-Host "Enabling Docker to listen on insecure port 2375"
cp C:\ProgramData\docker\runDockerDaemon.cmd C:\ProgramData\docker\runDockerDaemon.cmd.bak
cat C:\ProgramData\docker\runDockerDaemon.cmd.bak | %{$_ -replace '^docker daemon -D -b "Virtual Switch"$','docker daemon -D -b "Virtual Switch" -H 0.0.0.0:2375'} | Set-Content C:\ProgramData\docker\runDockerDaemon.cmd

Write-Host "Stopping Docker"
Stop-Service docker

# Do not restart Docker as it creates the key.json with an unique ID
# This should not exist in the Vagrant basebox so you can spin up
# multiple Vagrant boxes for a Docker swarm etc.

Write-Host "Removing key.json to recreate key.json on first vagrant up"
rm C:\ProgramData\docker\config\key.json
