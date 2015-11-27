rem 
rem bin\test-box-vmware.bat ubuntu1204_vmware.box ubuntu1204
set quick=0

if "%1x"=="--quickx" (
  shift
  set quick=1
)
set box_path=%1
set box_name=%2
set box_suffix=vmware
set box_provider=vmware_desktop
set vagrant_provider=vmware_workstation
set vagrant_plugin=vagrant-vmware-workstation

set result=0
if "%VAGRANT_HOME%x"=="x" set VAGRANT_HOME=%USERPROFILE%\.vagrant.d

set tmp_path=boxtest
if exist %tmp_path% rmdir /s /q %tmp_path%

if %quick%==1 goto :do_test

rem vagrant plugin install vagrant-serverspec
rem vagrant plugin install %vagrant_plugin%
if exist c:\vagrant\resources\license.lic (
  if not exist %VAGRANT_HOME%\license-%vagrant_plugin%.lic (
    vagrant plugin license %vagrant_plugin% c:\vagrant\resources\license.lic
  )
)
vagrant box remove %box_name% --provider=%box_provider%
vagrant box add %box_name% %box_path%
if ERRORLEVEL 1 set result=%ERRORLEVEL%
if ERRORLEVEL 1 goto :done

:do_test
set result=0

mkdir %tmp_path%
pushd %tmp_path%
call :create_vagrantfile
echo USERPROFILE = %USERPROFILE%
if exist %USERPROFILE%\.ssh\known_hosts type %USERPROFILE%\.ssh\known_hosts
del /F %USERPROFILE%\.ssh\known_hosts
if exist %USERPROFILE%\.ssh\known_hosts echo known_hosts still here!!
vagrant up --provider=%vagrant_provider%
if ERRORLEVEL 1 set result=%ERRORLEVEL%

@echo Sleep 10 seconds
@ping 1.1.1.1 -n 1 -w 10000 > nul

vagrant destroy -f
if ERRORLEVEL 1 set result=%ERRORLEVEL%
popd

if %quick%==1 goto :done

vagrant box remove %box_name% --provider=%box_provider%
if ERRORLEVEL 1 set result=%ERRORLEVEL%

goto :done

:create_vagrantfile

rem to test if rsync / shared folder works
if not exist testdir\testfile.txt (
  mkdir testdir
  echo Works >testdir\testfile.txt
)

echo Vagrant.configure('2') do ^|config^| >Vagrantfile
echo   config.vm.define :"tst" do ^|tst^| >>Vagrantfile
echo     tst.vm.box = "%box_name%" >>Vagrantfile
echo     tst.vm.hostname = "tst"
echo     tst.vm.provision :serverspec do ^|spec^| >>Vagrantfile
echo       spec.pattern = '../test/*_%box_suffix%.rb' >>Vagrantfile
echo     end >>Vagrantfile
echo   end >>Vagrantfile
echo end >>Vagrantfile

exit /b

:done
exit %result%
