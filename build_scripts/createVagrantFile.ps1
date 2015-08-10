# encoding: utf-8

param($boxName)
$currentPath = (Get-Item -Path ".\" -Verbose).FullName;
$TARGETDIR = ".\..\boxes\$boxName";
if(!(Test-Path -Path $TARGETDIR )){
    New-Item -ItemType directory -Path $TARGETDIR
}
Copy-Item "..\vagrantfile-$boxName.template" "$TARGETDIR\vagrantfile"
## Move-Item "..\$boxName.box" "$TARGETDIR\$boxName.box" -force


$REPLACE1 = 'config.vm.define "' + $boxName + '"';
$REPLACE2 = 'config.vm.box = "' + $boxName + '"';
$REPLACE3 = 'config.vm.box_url = "' + $boxName + '.box"';
(Get-Content "$TARGETDIR\vagrantfile") | 
Foreach-Object {$_ -replace 'config.vm.define .*$', $REPLACE1}  | 
Out-File "$TARGETDIR\vagrantfile" -encoding utf8

(Get-Content "$TARGETDIR\vagrantfile") | 
Foreach-Object {$_ -replace 'config.vm.box = .*$', $REPLACE2}  | 
Out-File "$TARGETDIR\vagrantfile" -encoding utf8