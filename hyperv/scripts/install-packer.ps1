$ProgressPreference = 'SilentlyContinue'
if (Test-Path $env:TEMP\packer.zip) {
  rm -force $env:TEMP\packer.zip
}
if (Test-Path $env:TEMP\packer) {
  rm -recurse -force $env:TEMP\packer
}
wget -outfile $env:TEMP\packer.zip -uri https://dl.bintray.com/taliesins/Packer/Packer.1.0.0.145-HyperV.nupkg -UseBasicParsing
Expand-Archive $env:TEMP\packer.zip -DestinationPath $env:TEMP\packer
copy $env:TEMP\packer\packer.exe $env:ChocolateyInstall\bin\packer.exe
rm -force $env:TEMP\packer.zip
