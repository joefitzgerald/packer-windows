
resource "azurerm_virtual_network" "windows" {
    name = "windows-virtnet"
    address_space = ["10.0.0.0/16"]
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.global.name}"
}

resource "azurerm_subnet" "windows" {
    name = "windows-${format("%02d", count.index + 1)}-sn"
    resource_group_name = "${azurerm_resource_group.global.name}"
    virtual_network_name = "${azurerm_virtual_network.windows.name}"
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_network_interface" "windows" {
    count                        = "${var.count}"
    name = "windows-${format("%02d", count.index + 1)}-nic"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.global.name}"

    ip_configuration {
        name = "testconfiguration1"
        subnet_id = "${azurerm_subnet.windows.id}"
        public_ip_address_id          = "${element(azurerm_public_ip.windows.*.id, count.index)}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_public_ip" "windows" {
  count                        = "${var.count}"
  domain_name_label            = "${var.dns_prefix}-${format("%02d", count.index + 1)}"
  idle_timeout_in_minutes      = 30
  location                     = "${var.location}"
  name                         = "windows-${format("%02d", count.index + 1)}-publicip"
  public_ip_address_allocation = "dynamic"
  resource_group_name          = "${azurerm_resource_group.global.name}"
}

resource "azurerm_storage_container" "windows" {
  container_access_type = "private"
  count                 = "${var.count}"
  name                  = "windows-${format("%02d", count.index + 1)}-storage"
  resource_group_name   = "${azurerm_resource_group.global.name}"
  storage_account_name  = "${azurerm_storage_account.global.name}"
}

resource "azurerm_virtual_machine" "windows" {
    count                        = "${var.count}"
    name = "windows-${format("%02d", count.index + 1)}-vm"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.global.name}"
    network_interface_ids = ["${element(azurerm_network_interface.windows.*.id, count.index)}"]
    vm_size = "${var.vm_size}"

    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }

    storage_os_disk {
        name = "windows-${format("%02d", count.index + 1)}-osdisk"
        vhd_uri = "${azurerm_storage_account.global.primary_blob_endpoint}${element(azurerm_storage_container.windows.*.id, count.index)}/disk1.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

    os_profile {
        computer_name = "${var.dns_prefix}-${format("%02d", count.index + 1)}"
        admin_username = "${var.admin_username}"
        admin_password = "${var.admin_password}"
        custom_data = "${base64encode("Param($HostName = \"${var.dns_prefix}-${format("%02d", count.index + 1)}.${var.location}.${var.azure_dns_suffix}\", $Username=\"${var.admin_username}\", $Password=\"${var.admin_password}\") ${file("./provision.ps1")}")}"
    }

    os_profile_windows_config {
        provision_vm_agent = true
        enable_automatic_upgrades = true
        additional_unattend_config {
            pass = "oobeSystem"
            component = "Microsoft-Windows-Shell-Setup"
            setting_name = "AutoLogon"
            content = "<AutoLogon><Password><Value>${var.admin_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.admin_username}</Username></AutoLogon>"
        }
        additional_unattend_config {
            pass = "oobeSystem"
            component = "Microsoft-Windows-Shell-Setup"
            setting_name = "FirstLogonCommands"
            content = "${file("./FirstLogonCommands.xml")}"
        }
    }

    tags {
        environment = "staging"
    }
}
