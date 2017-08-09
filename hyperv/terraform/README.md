# Packer builder in Azure

This is a Terraform template to spin up a VM in Azure that has nested HyperV
activated and tools like Packer, Vagrant and Docker CLI installed.

Now you are able to build Vagrant base boxes for HyperV in the Cloud with Packer.

## Install Terraform

```
brew install terraform
```

## Secrets

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

## Configure

Adjust the file `variables.tf` to your needs to choose

- location / region
- DNS prefix and suffix
- size of the VM's, default is `Standard_D2_v3`
- username and password

## Plan

```bash
terraform plan
```

## Create / Apply

```bash
terraform apply
```

## Destroy

```bash
terraform destroy
```
