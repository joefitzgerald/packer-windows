Write-Host "Install-PackageProvider ..."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Write-Host "Install-Module ..."
Install-Module -Name DockerProvider -Force
Write-Host "Install-Package ..."
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
$ErrorActionStop = 'SilentlyContinue'
Install-Package -Name docker -ProviderName DockerProvider -RequiredVersion preview -Force
Set-PSRepository -InstallationPolicy Untrusted -Name PSGallery
Start-Service docker
