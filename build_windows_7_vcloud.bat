if exist windows_7_vcloud.box (
  del /Y windows_7_vcloud.box
)

packer build -only=vmware-iso windows_7_vcloud.json

