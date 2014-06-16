if exist windows_7_vcloud.box (
  del /F windows_7_vcloud.box
)

packer build -only=vmware-iso windows_7_vcloud.json

