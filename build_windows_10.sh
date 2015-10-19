#!/bin/bash
mkdir -p ./tmp/10/
echo "Inserting license ..."
sed -e "s/\<ProductKey\>/\<ProductKey\>\<Key\>$(pass windows_7_prof_license)\<\/Key\>/" ./answer_files/10/Autounattend.xml > ./tmp/10/Autounattend.xml
diff ./answer_files/10/Autounattend.xml ./tmp/10/Autounattend.xml
packer build --only=vmware-iso --var autounattend=./tmp/10/Autounattend.xml windows_10.json
