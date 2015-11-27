if exist windows_2008_r2_virtualbox.box (
  del /F windows_2008_r2_virtualbox.box
)

packer build -only=virtualbox-iso windows_2008_r2.json

if exist windows_2008_r2_virtualbox.box (
  rem vagrant box remove windows_2008_r2 --provider=virtualbox
  rem vagrant box add windows_2008_r2 windows_2008_r2_virtualbox.box 
  rem del /F windows_2008_r2_virtualbox.box
)
