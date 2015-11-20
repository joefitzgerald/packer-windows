rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/inplace_setup
powershell.exe -Command "wget -uri https://aka.ms/tp4/Install-ContainerHost -OutFile C:\Install-ContainerHost-1.ps1"

rem patch the install script, see https://github.com/Microsoft/Virtualization-Documentation/pull/90
powershell.exe -Command "cat C:\Install-ContainerHost-1.ps1 | %%{$_ -replace 'qfe =','qfe = 0 #'} | Set-Content C:\Install-ContainerHost.ps1"

powershell.exe -File "C:\Install-ContainerHost.ps1" -HyperV

echo Done with %0

rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/manage_docker
