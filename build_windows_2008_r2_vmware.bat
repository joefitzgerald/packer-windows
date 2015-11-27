if exist windows_2008_r2_vmware.box (
  del /F windows_2008_r2_vmware.box
)

packer build -only=vmware-iso windows_2008_r2.json

if exist windows_2008_r2_vmware.box (
  call vagrant box remove windows_2008_r2 --provider=vmware_workstation
  call vagrant box add windows_2008_r2 windows_2008_r2_vmware.box 
  rem del /F windows_2008_r2_vmware.box
)
