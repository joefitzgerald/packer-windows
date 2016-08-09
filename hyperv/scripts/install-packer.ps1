cd $env:TEMP
wget -outfile Packer.zip -uri https://dl.bintray.com/taliesins/Packer/Packer.1.0.0.127-Develop.nupkg -UseBasicParsing
Expand-Archive packer.zip
copy packer\packer.exe $env:ChocolateyInstall\bin\packer.exe
