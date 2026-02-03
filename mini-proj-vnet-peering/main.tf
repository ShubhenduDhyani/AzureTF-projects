resource "azurerm_resource_group" "rg" {
  name     = "vnet-peering-rg"
  location = "Central India"
}

#VM1 in Subnet1 of VNet1
resource "azurerm_network_interface" "nic-1" {
  name                = "vm1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vm-1" {
  name                = "vm1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic-1.id]
  vm_size             =   "Standard_D2ps_v5"

  storage_image_reference {
   publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-arm64"
    version   = "latest"
  }

  storage_os_disk {
    name              = "vm1-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm1"
    admin_username = "adminuser"
    admin_password = "Hello@1234567"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


#VM2 in Subnet2 of VNet2
resource "azurerm_network_interface" "nic-2" {
  name                = "vm2-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-2.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "vm-2" {
  name                = "vm2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic-2.id]
  vm_size             =   "Standard_D2ps_v5"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-arm64"
    version   = "latest"
  }

  storage_os_disk {
    name              = "vm2-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm2"
    admin_username = "adminuser"
    admin_password = "Hello@1234567"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}