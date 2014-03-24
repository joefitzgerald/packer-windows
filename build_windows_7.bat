if exist windows_7_virtualbox.box (
  del /Y windows_7_virtualbox.box
)

packer build -only=virtualbox-iso windows_7.json

if exist windows_7_virtualbox.box (
  call vagrant box remove windows_7
  call vagrant box add windows_7 windows_7_virtualbox.box 
  rem del /Y windows_7_virtualbox.box
)
