resource "azurerm_virtual_network_peering" "peer_from_hub_to_spoke1" {
  name                          = "hub-peering-to-finance-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.spoke1_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_spoke1_to_hub" {
  name                          = "finance-peering-to-hub-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.spoke1_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_hub_to_spoke2" {
  name                          = "hub-peering-to-it-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.spoke2_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_spoke2_to_hub" {
  name                          = "it-peering-to-hub-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.spoke2_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_proxyout_to_spoke1" {
  name                          = "proxyout-peering-to-finance-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.proxyout_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.spoke1_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_spoke1_to_proxyout" {
  name                          = "finance-peering-to-proxyout-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.spoke1_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.proxyout_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_proxyout_to_spoke2" {
  name                          = "proxyout-peering-to-it-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.proxyout_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.spoke2_vnet.id
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "peer_from_spoke2_to_proxyout" {
  name                          = "it-peering-to-proxyout-vnet"
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name          = azurerm_virtual_network.spoke2_vnet.name
  remote_virtual_network_id     = azurerm_virtual_network.proxyout_vnet.id
  allow_virtual_network_access  = true
}