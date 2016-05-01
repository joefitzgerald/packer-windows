net localgroup docker /add
net localgroup docker vagrant /add

(Get-Content C:\ProgramData\docker\runDockerDaemon.cmd).replace('-H npipe://', '-G docker -H npipe://') | Set-Content C:\ProgramData\docker\runDockerDaemon.cmd

# restart-service docker
# logoff and logon again
