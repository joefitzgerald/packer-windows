{{define "disks"}}
<DiskConfiguration>
    <Disk wcm:action="add">
        <CreatePartitions>
            <CreatePartition wcm:action="add">
                <Type>Primary</Type>
                <Order>1</Order>
                <Size>350</Size>
            </CreatePartition>
            <CreatePartition wcm:action="add">
                <Order>2</Order>
                <Type>Primary</Type>
                <Size>15360</Size>
            </CreatePartition>
            <CreatePartition wcm:action="add">
                <Order>3</Order>
                <Type>Primary</Type>
                <Extend>true</Extend>
            </CreatePartition>
        </CreatePartitions>
        <ModifyPartitions>
            <ModifyPartition wcm:action="add">
                <Active>true</Active>
                <Format>NTFS</Format>
                <Label>boot</Label>
                <Order>1</Order>
                <PartitionID>1</PartitionID>
            </ModifyPartition>
            <ModifyPartition wcm:action="add">
                <Format>NTFS</Format>
                <Label>nano</Label>
                <Letter>E</Letter>
                <Order>2</Order>
                <PartitionID>2</PartitionID>
            </ModifyPartition>
            <ModifyPartition wcm:action="add">
                <Format>NTFS</Format>
                <Label>2016</Label>
                <Letter>C</Letter>
                <Order>3</Order>
                <PartitionID>3</PartitionID>
            </ModifyPartition>
        </ModifyPartitions>
        <DiskID>0</DiskID>
        <WillWipeDisk>true</WillWipeDisk>
    </Disk>
</DiskConfiguration>
<ImageInstall>
    <OSImage>
        <InstallFrom>
            <MetaData wcm:action="add">
                <Key>/IMAGE/NAME </Key>
                <Value>{{.WindowsImageName}}</Value>
            </MetaData>
        </InstallFrom>
        <InstallTo>
            <DiskID>0</DiskID>
            <PartitionID>3</PartitionID>
        </InstallTo>
    </OSImage>
</ImageInstall>
{{end}}
