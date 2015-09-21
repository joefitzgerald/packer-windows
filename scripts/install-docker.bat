rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/inplace_setup
powershell.exe -Command "wget -uri http://aka.ms/setupcontainers -OutFile C:\ContainerSetup.ps1"
powershell.exe -File "C:\ContainerSetup.ps1"

rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/manage_docker

echo ======= PAUSE ========
ping 127.0.0.1 -n 3600 > nul

echo ======= PAUSE DONE ===
