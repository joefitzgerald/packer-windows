wget -outfile $env:TEMP\Packer.zip -uri https://dl.bintray.com/taliesins/Packer/Packer.1.0.0.104-HyperV.nupkg -UseBasicParsing
Expand-Archive $env:TEMP\packer.zip
