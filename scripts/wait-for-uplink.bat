echo Sleeping until internet is available

@setlocal enableextensions enabledelayedexpansion
@echo off
set ipaddr=8.8.8.8
:loop
set state=down
for /f "tokens=5,7" %%a in ('ping -n 1 !ipaddr!') do (
    if "x%%a"=="xReceived" if "x%%b"=="x1," set state=up
)
echo.Link is !state!
ping -n 5 127.0.0.1 >nul: 2>nul:
if "%state%"=="down" goto :loop
endlocal
