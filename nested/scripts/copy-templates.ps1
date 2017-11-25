mkdir $env:USERPROFILE\packer-windows
cd $env:USERPROFILE\packer-windows
copy \vagrant\*.json .
copy \vagrant\vag* .
copy -re \vagrant\answer_files\ answer_files
copy -re \vagrant\floppy\ floppy
copy -re \vagrant\scripts\ scripts
if (Test-Path \vagrant\packer_cache\) {  
  copy -re \vagrant\packer_cache\ packer_cache
}
