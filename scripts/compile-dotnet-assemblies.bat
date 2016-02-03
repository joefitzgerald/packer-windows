::http://support.microsoft.com/kb/2570538
::http://robrelyea.wordpress.com/2007/07/13/may-be-helpful-ngen-exe-executequeueditems/

if exist %windir%\microsoft.net\framework\v4.0.30319\ngen.exe (
	%windir%\microsoft.net\framework\v4.0.30319\ngen.exe update /force /queue
	%windir%\microsoft.net\framework\v4.0.30319\ngen.exe executequeueditems
)
if exist %windir%\microsoft.net\framework64\v4.0.30319\ngen.exe (
	%windir%\microsoft.net\framework64\v4.0.30319\ngen.exe update /force /queue
	%windir%\microsoft.net\framework64\v4.0.30319\ngen.exe executequeueditems
)

:: continue even if ngen fails
exit /b 0