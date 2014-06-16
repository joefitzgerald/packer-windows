if exist windows_81_virtualbox.box (
  del /F windows_81_virtualbox.box
)

packer build -only=virtualbox-iso windows_81.json

if exist windows_81_virtualbox.box (
  call vagrant box remove windows_81
  call vagrant box add windows_81 windows_81_virtualbox.box 
  rem del /Y windows_81_virtualbox.box
)
