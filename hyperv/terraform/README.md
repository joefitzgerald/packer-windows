# Packer builder in Azure

This is a Terraform template to spin up a VM in Azure that has nested HyperV
activated and tools like Packer, Vagrant and Docker CLI installed.

Now you are able to build Vagrant base boxes for HyperV in the Cloud with Packer.

## Stage 1: Spin up the Azure VM with Terraform

### Install Terraform

```
brew install terraform
```

### Secrets

Get your Azure ID's and secret with `pass`

```
eval $(pass azure-terraform)
```

You will need these environment variables for terraform

```
export ARM_SUBSCRIPTION_ID="uuid"
export ARM_CLIENT_ID="uuid"
export ARM_CLIENT_SECRET="secret"
export ARM_TENANT_ID="uuid"
```

### Configure

Adjust the file `variables.tf` to your needs to choose

- location / region
- DNS prefix and suffix
- size of the VM's, default is `Standard_D2_v3` which is needed for nested virtualization
- username and password

### Plan

```bash
terraform plan
```

### Create / Apply

Create the Azure VM with. After 5 minutes the VM should be up and running, and the provision.ps1 script will run inside the VM to install Packer, Vagrant, HyperV and then reboots the VM.

```bash
terraform apply
```

## Stage 2: Packer build

Now RDP into the Azure VM. Open a PowerShell terminal and clone my packer-windows repo or any other repo with a Packer template for HyperV.

```
git clone https://github.com/StefanScherer/packer-windows
mkdir D:\packer_cache
$env:PACKER_CACHE="D:\packer_cache"
cd packer-windows
packer build --only=hyperv-iso --var hyperv_switchname=ext windows_2016_docker.json
```

Packer creates an external Hyper-V virtual switch with name "ext". It downloads the eval ISO file and boots a Hyper-V VM to run the whole packer build configuration.

You could also try to run it in this Azure VM with

```
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
cd ..
git clone https://github.com/StefanScherer/docker-windows-box
cd docker-windows-box
vagrant up
```

### packer push

Now you can push the Vagrant box to Vagrant Cloud (https://app.vagrantup.com).
