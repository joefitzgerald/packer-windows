
set TEMP=C:\Windows\Temp
powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" <NUL
cmd /c setx /m PATH "%path%;C:\\Chocolatey\bin"
