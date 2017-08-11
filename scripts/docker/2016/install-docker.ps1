Write-Host "Install-PackageProvider ..."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Write-Host "Install-Module ..."
Install-Module -Name DockerMsftProviderInsider -Force
Write-Host "Install-Package ..."
Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
Install-Package -Name docker -ProviderName DockerMsftProviderInsider -Force -RequiredVersion 17.06.0-ce
Set-PSRepository -InstallationPolicy Untrusted -Name PSGallery
Start-Service docker
