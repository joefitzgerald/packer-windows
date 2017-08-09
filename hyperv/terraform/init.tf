# Configure the Microsoft Azure Provider
provider "azurerm" {}

# Create a resource group
resource "azurerm_resource_group" "global" {
  location = "${var.location}"
  name     = "${var.account}"
}

# Create a storage account
resource "azurerm_storage_account" "global" {
  account_type        = "Standard_LRS"                          # Only locally redundant
  location            = "${var.location}"
  name                = "${var.account}"
  resource_group_name = "${azurerm_resource_group.global.name}"
}
