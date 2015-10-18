rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/inplace_setup
powershell.exe -Command "wget -uri http://aka.ms/setupcontainers -OutFile C:\ContainerSetup.ps1"

set WIMPATH=http://192.168.254.1:8000/ContainerOSImage.wim
set LOCALWIMPATH=C:\Users\vagrant\ContainerOSImage.wim

if "%WIMPATH%x"=="x" (
  powershell.exe -File "C:\ContainerSetup.ps1"
) else (
  powershell.exe -Command "wget -uri %WIMPATH% -OutFile %LOCALWIMPATH%"
)

:waiting
if not exist %LOCALWIMPATH% (
  echo Waiting for WimPath %LOCALWIMPATH%
  ping 127.0.0.1 -n 5 > nul
  goto waiting
  )

if exist %LOCALWIMPATH% (
    powershell.exe -File "C:\ContainerSetup.ps1" -WimPath %LOCALWIMPATH%
    del %LOCALWIMPATH%
  ) else (
    powershell.exe -File "C:\ContainerSetup.ps1"
  )
)

echo Done with %0

rem https://msdn.microsoft.com/virtualization/windowscontainers/quick_start/manage_docker
