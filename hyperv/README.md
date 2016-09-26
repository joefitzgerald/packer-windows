# hyperv

This Vagrant environment can be used to spin up a Windows 10 VM to create the 2016 Hyper-V Vagrant boxes.
The VM needs about 6GByte RAM and 100 GByte disk.
Tested with VMware Fusion 8 and VMware Workstation 12.

## On your OSX/Windows host
### Build the Windows 10 VMware base box

Build the Windows 10 base box for VMware Fusion/Workstation with 100GByte disk size.

```bash
cd ..
packer build --only=vmware-iso -var disk_size=102400 windows_10.json
vagrant box add windows_10 windows_10_vmware.box
```

### Build the Windows 10 Hyper-V environment

Now build the Vagrant environment with Hyper-V and packer in a Windows 10 VM.

```bash
cd hyperv
vagrant up --provider vmware_fusion
```

## In the Windows 10 VM
### Build the Windows Server 2016 Hyper-V base box

Now inside the Windows 10 VM create a Hyper-V external switch and then run
packer with this command

```powershell
cd C:\vagrant
packer build --only=hyperv-iso -var 'hyperv_switchname=Wifi' windows_2016_docker.iso
```

You probably have to copy the C:\vagrant folder into the VM as packer would work
on a shared folder of the host.

### Run the Hyper-V VM in Windows 10

```powershell
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
cd C:\Users\vagrant
git clone https://github.com/StefanScherer/docker-windows-box
cd docker-windows-box
vagrant up
```
