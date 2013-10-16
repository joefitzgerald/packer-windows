if not exist "C:\Windows\Temp\7z920-x64.msi" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.sourceforge.net/sevenzip/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\Windows\Temp\7z920-x64.msi

if "%PACKER_BUILDER_TYPE%" equ "vmware" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox" goto :virtualbox
goto :done

:vmware

if not exist "C:\Windows\Temp\VMWare\setup.exe" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://softwareupdate.vmware.com/cds/vmw-desktop/ws/10.0.0/1295980/windows/packages/tools-windows-9.6.0.exe.tar', 'C:\Windows\Temp\vmware-tools.exe.tar')" <NUL
  cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\vmware-tools.exe.tar -oC:\Windows\Temp"
  cmd /c C:\Windows\Temp\tools-windows-9.6.0
  cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\Program Files ^(x86^)\VMWare\tools-windows\windows.iso" -oC:\Windows\Temp\VMWare"
  del /F /S /Q "C:\Program Files (x86)\VMWare"
)

cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"
goto :done

:virtualbox

:: There needs to be Oracle CA (Certificate Authority) certificates installed in order
:: to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer

mv C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"
cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
goto :done

:done
msiexec /qb /x C:\Windows\Temp\7z920-x64.msi
