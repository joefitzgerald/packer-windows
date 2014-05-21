if exist windows_81_vcloud.box (
  del /Y windows_81_vcloud.box
)

packer build -only=vmware-iso windows_81_vcloud.json

