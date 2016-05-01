# Workaround for slow exiting containers:
# https://social.msdn.microsoft.com/Forums/en-US/e2751260-4494-4b60-999e-5ea27ccbe1db/workaround-to-increase-boot-time-for-windows-server-core-containers?forum=windowscontainers
Write-Host "Running windowsservercore once and tagging it as latest"

# Remove containers
if ($((docker ps -aq | Measure-Object -Line).Lines) -gt 0) {
    docker rm -f $(docker ps -aq)
}

# Untag if present
if ($((docker images | where { $_ -match "windowsservercore" } | where { $_ -match "latest" } | Measure-Object -Line).Lines) -gt 0) {
   docker rmi windowsservercore:latest
}

# Find the build
$build=docker images | where { $_ -match "windowsservercore" } | %{ $_.Split(' ')[3]; }

# Run a container once
docker run windowsservercore:$build cmd /s /c echo windowsservercore has started once

# Commit the container
$containerID=$(docker ps -aq)
$imageID=$(docker commit $containerID | %{ $_.Split(':')[1] })
docker tag $imageID windowsservercore:latest

# Remove the temporary container
docker rm $containerID
