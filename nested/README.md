# nested

With this Vagrant environment you can build for other hypervisors in a nested
VMware VM. Or you can have a look at the provision scripts how to install
all tools needed on bare metal.

## Preparation

On your host with VMware.

### Build the Windows 10 VMware base box

Build the Windows 10 base box for VMware Fusion/Workstation with 100GByte disk size.

```bash
cd ..
packer build --only=vmware-iso -var disk_size=102400 windows_10.json
vagrant box add windows_10 windows_10_vmware.box
```

## Hyper-V

Now build the Vagrant environment with Hyper-V and packer in a Windows 10 VM.

```bash
cd nested
vagrant up hyperv
```

### Build a Hyper-V Vagrant box

In the nested Windows 10 VM with Hyper-V first create an external virtual
switch in Hyper-V Manager. Then you can run Packer builds.

```powershell
cd C:\Users\vagrant\packer-windows
packer build --only=hyperv-iso --var hyperv_switchname=ext windows_2016_docker.iso
```

You can copy the boxes produced back to C:\vagrant folder
that is a shared folder of the host.

### Run the Hyper-V VM in Windows 10

```powershell
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
cd C:\Users\vagrant
git clone https://github.com/StefanScherer/docker-windows-box
cd docker-windows-box
vagrant up
```

## VirtualBox

Now build the Vagrant environment with VirtualBox and packer in a Windows 10 VM.

```bash
cd nested
vagrant up virtualbox
```

### Build a VirtualBox Vagrant box

In the nested Windows 10 VM with VirtualBox installed you can run Packer builds.

```powershell
cd C:\Users\vagrant\packer-windows
packer build --only=virtualbox-iso windows_2016_docker.iso
```

You can copy the boxes produced back to C:\vagrant folder
that is a shared folder of the host.

### Run the VirtualBox VM in Windows 10

```powershell
vagrant box add windows_2016_docker windows_2016_docker_virtualbox.box
cd C:\Users\vagrant
git clone https://github.com/StefanScherer/docker-windows-box
cd docker-windows-box
vagrant up
```
