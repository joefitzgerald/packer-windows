if exist windows_2008_r2_virtualbox.box (
  del /Y windows_2008_r2_virtualbox.box
)

packer build -only=virtualbox-iso windows_2008_r2.json

if exist windows_2008_r2_virtualbox.box (
  call vagrant box remove windows_2008_r2
  call vagrant box add windows_2008_r2 windows_2008_r2_virtualbox.box 
  rem del /Y windows_2008_r2_virtualbox.box
)
