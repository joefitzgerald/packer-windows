if exist windows_7_virtualbox.box (
  del /F windows_7_virtualbox.box
)

packer build -only=virtualbox-iso windows_7.json

if exist windows_7_virtualbox.box (
  call vagrant box remove windows_7 --provider=virtualbox
  call vagrant box add windows_7 windows_7_virtualbox.box 
  rem del /F windows_7_virtualbox.box
)
