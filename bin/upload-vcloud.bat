set BUILD=%1

if "%BUILD%x"=="uploadx" (
  set BUILD=%2
)

@if "%BUILD:~-7%" == "_vcloud" (
  set boxname=%BUILD:~0,-7%
  set template=%BUILD%
)

@if "%boxname%x"=="x" (
  echo Wrong build parameter!
  set result=1
  goto :EOF
)

@echo.
@echo boxname = %boxname%
@echo template = %template%
@echo.

set box_filename=%boxname%_vcloud.box
set box_provider=vcloud

set result=0

vagrant box remove %boxname% --provider=%box_provider%
if exist %box_filename% (
  echo "Use %box_filename% from current dir"
  vagrant box add %boxname% %box_filename%
) else (
  echo "Use %box_filename% from other jenkins workspace dir"
  vagrant box add %boxname% c:\jenkins\workspace\%boxname%_%box_provider%\%box_filename%
)
if ERRORLEVEL 1 set result=%ERRORLEVEL%
if ERRORLEVEL 1 goto :done

@set vcloud_hostname=roecloud001

if "%VAGRANT_HOME%x"=="x" set VAGRANT_HOME=%USERPROFILE%\.vagrant.d

@set vcloud_hostname=YOUR-VCLOUD
@set vcloud_username=YOUR-UPLOAD-USER
@set vcloud_password=S@perS$cretP1ass
@set vcloud_org=YOUR-GLOBAL-ORG
@set vcloud_catalog=YOUR-GLOBAL-CATALOG
@set vcloud_vdc=YOUR-GLOBAL-VDC

if exist c:\vagrant\resources\upload-vcloud-credentials.bat call c:\vagrant\resources\upload-vcloud-credentials.bat

echo Uploading %boxname%.ovf to vCloud %vcloud_hostname% / %vcloud_org% / %vcloud_catalog% / %boxname%
@ovftool --acceptAllEulas --vCloudTemplate --overwrite %VAGRANT_HOME%\boxes\%boxname%\0\%box_provider%\%boxname%.ovf "vcloud://%vcloud_username%:%vcloud_password%@%vcloud_hostname%:443?org=%vcloud_org%&vappTemplate=%boxname%&catalog=%vcloud_catalog%&vdc=%vcloud_vdc%"
if ERRORLEVEL 1 goto :first_upload
goto :uploaded
:first_upload
@ovftool --acceptAllEulas --vCloudTemplate %VAGRANT_HOME%\boxes\%boxname%\0\%box_provider%\%boxname%.ovf "vcloud://%vcloud_username%:%vcloud_password%@%vcloud_hostname%:443?org=%vcloud_org%&vappTemplate=%boxname%&catalog=%vcloud_catalog%&vdc=%vcloud_vdc%"
if ERRORLEVEL 1 goto :error_vcloud_upload

:uploaded
vagrant box remove %boxname% --provider=%box_provider%
if ERRORLEVEL 1 set result=%ERRORLEVEL%

:error_vcloud_upload
echo Error Uploading box to vCloud with ovftool!
set result=%ERRORLEVEL%
goto :done

:done
exit %result%
