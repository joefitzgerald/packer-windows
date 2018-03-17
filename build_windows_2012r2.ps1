#packer build --only=vmware-iso `
#       --var disk_size=102400 `
#       --var iso_url=C:/packer_cache/Win10_1607_English_x64.iso `
#       --var iso_checksum=99fd8082a609997ae97a514dca22becf20420891 `
#       --var autounattend=./tmp/10/Autounattend.xml `
#       windows_10.json

# bigger disk for hyperv
packer build --only=hyperv-iso `
       --var iso_url='C:\ISOs\WindowsServer2012R2.ISO' `
       windows_2012_r2.json
