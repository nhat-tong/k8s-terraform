resource "azurerm_lb" "proxyout_lb" {
  name                = "proxyout-lb"
  location            = var.proxyout_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "proxyout-lb-ip-config"
    private_ip_address   = "10.2.0.4"
    subnet_id            = azurerm_subnet.proxyout_subnet.id
  }
}

resource "azurerm_lb_backend_address_pool" "proxyout_backend_pool" {
  resource_group_name  = azurerm_resource_group.hub_spoke_rg.name
  loadbalancer_id      = azurerm_lb.proxyout_lb.id
  name                 = "proxyout-backendpool"
}

resource "azurerm_lb_probe" "proxyout_probe" {
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  loadbalancer_id     = azurerm_lb.proxyout_lb.id
  name                = "proxyout-probe"
  protocol            = "tcp"
  port                = 22
}

resource "azurerm_lb_rule" "proxyout_rule_80" {
  resource_group_name            = azurerm_resource_group.hub_spoke_rg.name
  loadbalancer_id                = azurerm_lb.proxyout_lb.id
  name                           = "proxyout-rule-80"
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "proxyout-lb-ip-config"
  probe_id                       = azurerm_lb_probe.proxyout_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.proxyout_backend_pool.id
}

resource "azurerm_lb_rule" "proxyout_rule_443" {
  resource_group_name            = azurerm_resource_group.hub_spoke_rg.name
  loadbalancer_id                = azurerm_lb.proxyout_lb.id
  name                           = "proxyout-rule-443"
  protocol                       = "tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "proxyout-lb-ip-config"
  probe_id                       = azurerm_lb_probe.proxyout_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.proxyout_backend_pool.id
}