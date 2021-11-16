resource "azurerm_public_ip" "nat_pip" {
  name                = "proxyout-nat-pip"
  location            = var.proxyout_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "proxyout_nat" {
  name                = "proxyout-nat-gateway"
  location            = var.proxyout_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "asso_nat_pip" {
   nat_gateway_id       = azurerm_nat_gateway.proxyout_nat.id
   public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "asso_nat_subnet" {
  nat_gateway_id = azurerm_nat_gateway.proxyout_nat.id
  subnet_id      = azurerm_subnet.proxyout_subnet.id
}