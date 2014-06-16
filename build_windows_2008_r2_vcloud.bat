if exist windows_2008_r2_vcloud.box (
  del /F windows_2008_r2_vcloud.box
)

packer build -only=vmware-iso windows_2008_r2_vcloud.json

