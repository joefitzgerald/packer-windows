# Packer + Azure

Steps from the blog post http://blog.geuer-pollmann.de/blog/2016/09/21/azure-germany-loves-packer/

## Security Setup

### UsingPowerShell

Read https://david-obrien.net/2016/06/use-packer-with-azurerm/

### Using Azure CLI

Read https://www.packer.io/docs/builders/azure-setup.html

First, you create an app in Azure Active Directory:

```
azure ad app create --json \
  --name "Service Principal Packer" \
  --home-page "https://packer.io" \
  --identifier-uris "https://packer.io" \
  --key-type Password \
  --password SuperLongPassword123.-
```

The output of this command shows you the application ID **appId**:

In the next step, we promote our app to be a "service principal", and we list
the service principals we have:

```
azure ad sp create --json -vv --applicationId 1326f47c-eaea-42aa-8aa8-ff99fbaf3da9
```

You will get the **appId** and the **objectId**.

Now lookup you Azure Active Directory TenantID with

```
azure account show --json | jq '.[].tenantId'
```

Now lookup your Azure Subscription ID with

```
azure account show --json | jq '.[].id'
```

As a last step of the security setup, you can assign your service principal ‘Contributor’ rights to your subscription (replace $spObjectId and $subscriptionId with proper values):

```
azure role assignment create \
  --objectId $spObjectId \
  --roleName Contributor \
  --scope "/subscriptions/$subscriptionId"
```

## Pick a location

```
azure location list
```

## Pick a VM

First list the publishers, but normally we choose `MicrosoftWindowsServer` as publisher.

```
azure vm image list-publishers westeurope
```

Now list the images available for that publisher

```
azure vm image list -l westeurope MicrosoftWindowsServer
```

The interesting ones might be

```
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter                  Windows  2016.0.20161010  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter:2016.0.20161010                
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter                  Windows  2016.0.20161108  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter:2016.0.20161108                
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter                  Windows  2016.0.20161213  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter:2016.0.20161213                
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter-with-Containers  Windows  2016.0.20161012  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter-with-Containers:2016.0.20161012
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter-with-Containers  Windows  2016.0.20161025  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter-with-Containers:2016.0.20161025
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter-with-Containers  Windows  2016.0.20161108  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter-with-Containers:2016.0.20161108
data:    MicrosoftWindowsServer  WindowsServer      2016-Datacenter-with-Containers  Windows  2016.0.20161213  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Datacenter-with-Containers:2016.0.20161213
data:    MicrosoftWindowsServer  WindowsServer      2016-Nano-Server                 Windows  2016.0.20161012  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Nano-Server:2016.0.20161012               
data:    MicrosoftWindowsServer  WindowsServer      2016-Nano-Server                 Windows  2016.0.20161109  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Nano-Server:2016.0.20161109               
data:    MicrosoftWindowsServer  WindowsServer      2016-Nano-Server                 Windows  2016.0.20170113  westeurope  MicrosoftWindowsServer:WindowsServer:2016-Nano-Server:2016.0.20170113               
```


**TODO** Describe how to create the resource group and storage account needed by packer build. I've used an existing resource group and storage account.

## Create Resource Group

```
azure group create myaccount westeurope
```

## Create a storage account

```
azure storage account create --sku-name LRS --location westeurope --kind BlobStorage --access-tier Cool --resource-group myaccount myaccount
```

## Store secrets in pass

I use `pass` for my secrets.

```
export PACKER_AZURE_AD_TENANT_ID=xxx
export PACKER_AZURE_SUBSCRIPTION_ID=xxx
export PACKER_AZURE_OBJECT_ID=xxx
export PACKER_AZURE_APP_ID=xxx
export PACKER_AZURE_CLIENT_SECRET='xxx'
export PACKER_AZURE_RESOURCE_GROUP=myaccount
export PACKER_AZURE_STORAGE_ACCOUNT=myaccount
```

## Build

Load your secrets and run the packer build

```
eval $(pass packer-azure)
packer build windows_2016_docker_azure.json
```

## Copy vhd

### Create a public container

Create a public container, eg. `vhds`

### Copy blob

```
azure storage blob copy start https://myaccount.blob.core.windows.net/system/Microsoft.Compute/Images/images/WindowsServer2016Docker-osDisk.vhd vhds
azure storage blob copy start https://myaccount.blob.core.windows.net/system/Microsoft.Compute/Images/images/WindowsServer2016Docker-osDisk.vhd --dest-container vhds --dest-blob WindowsServer2016Docker.20170122-osDisk.vhd
```
