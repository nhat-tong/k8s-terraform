resource "azurerm_resource_group" "hub_spoke_rg" {
    name = var.resource_group_name
    location = var.resource_group_location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  location            = var.hub_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  address_space       = ["10.22.0.0/27"]
}

resource "azurerm_network_security_group" "hub_nsg" {
  name                = var.hub_nsg_name
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_virtual_network.hub_vnet.location

  security_rule {
    name                       = "Allow_Inbound_TCP22_TCP3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = var.source_address_hub
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "hub_subnet" {
  name                                              = var.hub_subnet_name
  resource_group_name                               = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name                              = azurerm_virtual_network.hub_vnet.name
  address_prefixes                                  = ["10.22.0.0/28"]
  enforce_private_link_endpoint_network_policies    = false
}

resource "azurerm_subnet_network_security_group_association" "asso_hub_nsg_subnet" {
  subnet_id                 = azurerm_subnet.hub_subnet.id
  network_security_group_id = azurerm_network_security_group.hub_nsg.id
}

resource "azurerm_virtual_network" "spoke1_vnet" {
  name                = var.spoke1_vnet_name
  location            = var.spoke1_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  address_space       = ["10.23.0.0/28"]
}

resource "azurerm_network_security_group" "spoke1_nsg" {
  name                = var.spoke1_nsg_name
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_virtual_network.spoke1_vnet.location

  security_rule {
    name                       = "Allow_Inbound_TCP22_TCP3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = var.source_address_spoke1_authorized
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "spoke1_subnet" {
  name                                              = var.spoke1_subnet_name
  resource_group_name                               = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name                              = azurerm_virtual_network.spoke1_vnet.name
  address_prefixes                                  = ["10.23.0.0/28"]
  enforce_private_link_endpoint_network_policies    = false
}

resource "azurerm_subnet_network_security_group_association" "asso_spoke1_nsg_subnet" {
  subnet_id                 = azurerm_subnet.spoke1_subnet.id
  network_security_group_id = azurerm_network_security_group.spoke1_nsg.id
}

resource "azurerm_virtual_network" "spoke2_vnet" {
  name                = var.spoke2_vnet_name
  location            = var.spoke2_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  address_space       = ["10.23.1.32/28"]
}

resource "azurerm_network_security_group" "spoke2_nsg" {
  name                = var.spoke2_nsg_name
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_virtual_network.spoke2_vnet.location

  security_rule {
    name                       = "Allow_Inbound_TCP22_TCP3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = var.source_address_spoke2_authorized
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "spoke2_subnet" {
  name                                              = var.spoke2_subnet_name
  resource_group_name                               = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name                              = azurerm_virtual_network.spoke2_vnet.name
  address_prefixes                                  = ["10.23.1.32/28"]
  enforce_private_link_endpoint_network_policies    = false
}

resource "azurerm_subnet_network_security_group_association" "asso_spoke2_nsg_subnet" {
  subnet_id                 = azurerm_subnet.spoke2_subnet.id
  network_security_group_id = azurerm_network_security_group.spoke2_nsg.id
}