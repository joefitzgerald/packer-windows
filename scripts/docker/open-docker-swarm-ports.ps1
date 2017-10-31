Write-Host "Opening Docker swarm mode ports"

if (!(Get-NetFirewallRule | where {$_.Name -eq "Dockerswarm2377"})) {
    New-NetFirewallRule -Name "Dockerswarm2377" -DisplayName "Docker Swarm Mode Management TCP/2377" -Protocol tcp -LocalPort 2377 -Action Allow -Enabled True
}
if (!(Get-NetFirewallRule | where {$_.Name -eq "Dockerswarm7946"})) {
    New-NetFirewallRule -Name "Dockerswarm7946" -DisplayName "Docker Swarm Mode Node Communication TCP/7946" -Protocol tcp -LocalPort 7946 -Action Allow -Enabled True
}
if (!(Get-NetFirewallRule | where {$_.Name -eq "Dockerswarm7946udp"})) {
    New-NetFirewallRule -Name "Dockerswarm7946udp" -DisplayName "Docker Swarm Mode Node Communication UDP/7946" -Protocol udp -LocalPort 7946 -Action Allow -Enabled True
}
if (!(Get-NetFirewallRule | where {$_.Name -eq "Dockerswarm4789"})) {
    New-NetFirewallRule -Name "Dockerswarm4789" -DisplayName "Docker Swarm Overlay Network Traffic TCP/4789" -Protocol tcp -LocalPort 4789 -Action Allow -Enabled True
}
