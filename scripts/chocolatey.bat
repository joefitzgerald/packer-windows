powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" <NUL

<nul set /p ".=;%ALLUSERSPROFILE%\chocolatey\bin" >> C:\Windows\Temp\PATH
set /p PATH=<C:\Windows\Temp\PATH
setx PATH "%PATH%" /m
