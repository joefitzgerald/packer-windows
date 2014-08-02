if exist windows_2012_r2_virtualbox.box (
  del /Y windows_2012_r2_virtualbox.box
)

packer build -only=virtualbox-iso windows_2012_r2.json

if exist windows_2012_r2_virtualbox.box (
  call vagrant box remove windows_2012_r2 --provider=virtualbox
  call vagrant box add windows_2012_r2 windows_2012_r2_virtualbox.box 
  rem del /Y windows_2012_r2_virtualbox.box
)
