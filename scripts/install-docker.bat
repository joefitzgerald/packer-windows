rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/inplace_setup
powershell.exe -Command "wget -uri http://aka.ms/setupcontainers -OutFile C:\ContainerSetup.ps1"

rem set WIMPATH=http://192.168.254.1:8000/ContainerOSImage

if "%WIMPATH%x"=="x" (
  powershell.exe -File "C:\ContainerSetup.ps1"
) else (
  powershell.exe -Command "wget -uri %WIMPATH% -OutFile C:\ContainerOSImage"
  if exist C:\ContainerOSImage (
    powershell.exe -File "C:\ContainerSetup.ps1" -WimPath C:\ContainerOSImage
  ) else (
    powershell.exe -File "C:\ContainerSetup.ps1"
  )
  del C:\ContainerOSImage
)

rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/manage_docker
