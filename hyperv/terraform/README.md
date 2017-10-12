# Packer Hyper-V builder in Azure

This is a Terraform template to spin up a VM in Azure that has nested Hyper-V
activated and tools like Git, Packer and Vagrant installed.

Now you are able to build Vagrant base boxes for Hyper-V in the Cloud with Packer.

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
- size of the VM's, default is `Standard_E2s_v3` which is needed for nested virtualization
- username and password

### Plan

```bash
terraform plan
```

### Create / Apply

Create the Azure VM with. After 5 minutes the VM should be up and running, and the provision.ps1 script will run inside the VM to install Packer, Vagrant, Hyper-V and then reboots the VM and adds the internal virtual switch 'packer-hyperv-iso' and DHCP server.

```bash
terraform apply
```

If you want more than one Packer VM, then use eg. `terraform apply -var count=3`.

## Stage 2: Packer build

Now RDP into the Azure VM `pckr-01.westeurope.cloudapp.azure.com` (the dns_prefix is specified in `variables.tf`). Open a PowerShell terminal and clone my packer-windows repo or any other repo with a Packer template for Hyper-V.

```
git clone https://github.com/StefanScherer/packer-windows
cd packer-windows
packer build --only=hyperv-iso windows_2016_docker.json
```

Packer uses the internal Hyper-V virtual switch with name "packer-hyperv-iso" which was creating during the provisioning of the Azure VM. Packer now downloads the eval ISO file and boots a Hyper-V VM to run the whole packer build configuration.

## Stage 3: Vagrant up

You could also try to run it in this Azure VM with

```
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
cd ..
git clone https://github.com/StefanScherer/docker-windows-box
cd docker-windows-box
vagrant up
vagrant rdp
```

### packer push

Now you can push the Vagrant box to Vagrant Cloud (https://app.vagrantup.com).
