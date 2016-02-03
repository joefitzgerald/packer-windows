::http://support.microsoft.com/kb/2570538
::http://robrelyea.wordpress.com/2007/07/13/may-be-helpful-ngen-exe-executequeueditems/

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64BIT

if exist "%windir%\microsoft.net\framework\v4.0.30319\ngen.exe" (
  %windir%\microsoft.net\framework\v4.0.30319\ngen.exe update /force /queue
  %windir%\microsoft.net\framework\v4.0.30319\ngen.exe executequeueditems
)

:: continue even if ngen fails
exit /b 0

:64BIT
if exist "%windir%\microsoft.net\framework\v4.0.30319\ngen.exe" (
  %windir%\microsoft.net\framework\v4.0.30319\ngen.exe update /force /queue
  %windir%\microsoft.net\framework64\v4.0.30319\ngen.exe update /force /queue
  %windir%\microsoft.net\framework\v4.0.30319\ngen.exe executequeueditems
  %windir%\microsoft.net\framework64\v4.0.30319\ngen.exe executequeueditems
)

:: continue even if ngen fails
exit /b 0
