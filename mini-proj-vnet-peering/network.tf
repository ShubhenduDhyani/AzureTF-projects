resource "azurerm_virtual_network" "vnet-1" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "vnet-peering-vnet1"
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet-1" {
  name                 = "vnet-peering-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  address_prefixes     = ["10.0.1.0/24"]
}

#bastion-vnet1
resource "azurerm_subnet" "bastion-subnet1" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  address_prefixes     = ["10.0.2.0/27"]
}

resource "azurerm_public_ip" "pip-1" {
  name                = "pip-bastion-vnet1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion-1" {
  name                = "bastion-host-vnet1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration-1"
    subnet_id            = azurerm_subnet.bastion-subnet1.id
    public_ip_address_id = azurerm_public_ip.pip-1.id
  }
}


resource "azurerm_virtual_network" "vnet-2" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "vnet-peering-vnet2"
  address_space = ["10.1.0.0/16"]
}
resource "azurerm_subnet" "subnet-2" {
  name                 = "vnet-peering-subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-2.name
  address_prefixes     = ["10.1.1.0/24"]
}

#bastion-vnet2
resource "azurerm_subnet" "bastion-subnet2" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-2.name
  address_prefixes     = ["10.1.2.0/27"]
}

resource "azurerm_public_ip" "pip-2" {
  name                = "pip-bastion-vnet2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion-2" {
  name                = "bastion-host-vnet2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration-2"
    subnet_id            = azurerm_subnet.bastion-subnet2.id
    public_ip_address_id = azurerm_public_ip.pip-2.id
  }
}


resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name = "peering-vnet1-to-vnet2"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-2.id
  }
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name = "peering-vnet2-to-vnet1"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet-2.name
    remote_virtual_network_id = azurerm_virtual_network.vnet-1.id
}