if exist windows_7_vmware.box (
  del /F windows_7_vmware.box
)

packer build -only=vmware-iso windows_7.json

if exist windows_7_vmware.box (
  call vagrant box remove windows_7 --provider=vmware_workstation
  call vagrant box add windows_7 windows_7_vmware.box 
  rem del /F windows_7_vmware.box
)
