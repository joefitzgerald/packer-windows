cd $env:TEMP
$ProgressPreference = 'SilentlyContinue'
if (Test-Path packer.zip) {
  rm -force packer.zip
}
if (Test-Path packer) {
  rm -recurse -force packer
}
wget -outfile packer.zip -uri https://dl.bintray.com/taliesins/Packer/Packer.1.0.0.145-HyperV.nupkg -UseBasicParsing
Expand-Archive packer.zip
copy packer\packer.exe $env:ChocolateyInstall\bin\packer.exe
rm -force packer.zip
