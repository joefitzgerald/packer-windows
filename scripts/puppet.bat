:: Windows 8 / Windows 2012 require .Net 3.5 to be installed

@echo off

:: get windows version
for /f "tokens=2 delims=[]" %%G in ('ver') do (set _version=%%G) 
for /f "tokens=2,3,4 delims=. " %%G in ('echo %_version%') do (set _major=%%G& set _minor=%%H& set _build=%%I) 

:: Version 6 or higher
if %_major% lss 6 goto :puppet

@echo on
powershell -Command "Install-WindowsFeature NET-Framework-Core"

:puppet

if not exist "C:\Windows\Temp\puppet.msi" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.puppetlabs.com/windows/puppet-3.5.1.msi', 'C:\Windows\Temp\puppet.msi')" <NUL
)

:: http://docs.puppetlabs.com/pe/latest/install_windows.html
msiexec /qn /i C:\Windows\Temp\puppet.msi /log C:\Windows\Temp\puppet.log

<nul set /p ".=;C:\Program Files (x86)\Puppet Labs\Puppet\bin" >> C:\Windows\Temp\PATH
set /p PATH=<C:\Windows\Temp\PATH
setx PATH "%PATH%" /m
