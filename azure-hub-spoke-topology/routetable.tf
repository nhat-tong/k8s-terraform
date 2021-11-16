resource "azurerm_route_table" "finance_route_table" {
  name                          = "finance-rt"
  location                      = var.spoke1_location
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  disable_bgp_route_propagation = false
}

resource "azurerm_route" "finance_subnet_route_internet" {
  name                    = "my-route-to-internet"
  resource_group_name     = azurerm_resource_group.hub_spoke_rg.name
  route_table_name        = azurerm_route_table.finance_route_table.name
  address_prefix          = "0.0.0.0/0"
  next_hop_type           = "VirtualAppliance"
  next_hop_in_ip_address  = "10.2.0.4"
}

resource "azurerm_route_table" "it_route_table" {
  name                          = "it-rt"
  location                      = var.spoke2_location
  resource_group_name           = azurerm_resource_group.hub_spoke_rg.name
  disable_bgp_route_propagation = false
}

resource "azurerm_route" "it_subnet_route_internet" {
  name                    = "my-route-to-internet"
  resource_group_name     = azurerm_resource_group.hub_spoke_rg.name
  route_table_name        = azurerm_route_table.it_route_table.name
  address_prefix          = "0.0.0.0/0"
  next_hop_type           = "VirtualAppliance"
  next_hop_in_ip_address  = "10.2.0.4"
}

resource "azurerm_subnet_route_table_association" "asso_finance_subnet_routetable" {
  subnet_id      = azurerm_subnet.spoke1_subnet.id
  route_table_id = azurerm_route_table.finance_route_table.id
}

resource "azurerm_subnet_route_table_association" "asso_it_subnet_routetable" {
  subnet_id      = azurerm_subnet.spoke2_subnet.id
  route_table_id = azurerm_route_table.it_route_table.id
}