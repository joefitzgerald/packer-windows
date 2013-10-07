
powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
cmd /c setx /m PATH "%path%;C:\\Chocolatey\bin"
