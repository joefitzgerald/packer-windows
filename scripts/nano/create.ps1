# Copyright 2015, Matt Wrock

start-transcript -path $env:temp\transcript0.txt -noclobber

mkdir c:\NanoServer
cd c:\NanoServer
xcopy /s d:\NanoServer\*.* .
Import-Module .\NanoServerImageGenerator.psm1
$adminPassword = ConvertTo-SecureString "vagrant" -AsPlainText -Force

New-NanoServerImage `
  -MediaPath D:\ `
  -BasePath .\Base `
  -TargetPath .\Nano\Nano.vhdx `
  -ComputerName Nano `
  -OEMDrivers `
  -ReverseForwarders `
  -AdministratorPassword $adminPassword

Mount-DiskImage -ImagePath "c:\NanoServer\nano\Nano.vhdx"

Copy-Item `
  -Path "H:\*" `
  -Destination "E:\" `
  -Force `
  -Recurse `
  -Exclude "System Volume Information" `
  -ErrorAction SilentlyContinue

# Boot from Nano next time
bcdedit /set "{current}" device "partition=E:"
bcdedit /set "{current}" osdevice "partition=E:"
bcdedit /set "{current}" detecthal on
bcdedit /set "{current}" path \windows\system32\boot\winload.exe
