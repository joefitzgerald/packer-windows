if exist windows_2012_r2_vmware.box (
  del /Y windows_2012_r2_vmware.box
)

packer build -only=vmware-iso windows_2012_r2.json

if exist windows_2012_r2_vmware.box (
  call vagrant box remove windows_2012_r2 --provider=vmware_workstation
  call vagrant box add windows_2012_r2 windows_2012_r2_vmware.box 
  rem del /Y windows_2012_r2_vmware.box
)
