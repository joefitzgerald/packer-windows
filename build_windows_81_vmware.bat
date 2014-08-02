if exist windows_81_vmware.box (
  del /F windows_81_vmware.box
)

packer build -only=vmware-iso windows_81.json

if exist windows_81_vmware.box (
  call vagrant box remove windows_81 --provider=vmware_workstation
  call vagrant box add windows_81 windows_81_vmware.box 
  rem del /Y windows_81_vmware.box
)
