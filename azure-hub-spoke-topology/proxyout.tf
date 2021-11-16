################### Create Virtual Network ###################################

resource "azurerm_virtual_network" "proxyout_vnet" {
  name                = var.proxyout_vnet_name
  location            = var.proxyout_location
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  address_space       = ["10.2.0.0/28"]
}

resource "azurerm_network_security_group" "proxyout_nsg" {
  name                = var.proxyout_nsg_name
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_virtual_network.proxyout_vnet.location

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

  security_rule {
    name                       = "Allow_Inbound_HTTP_HTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefixes    = ["10.23.0.0/28", "10.23.1.32/28"]
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "proxyout_subnet" {
  name                                              = var.proxyout_subnet_name
  resource_group_name                               = azurerm_resource_group.hub_spoke_rg.name
  virtual_network_name                              = azurerm_virtual_network.proxyout_vnet.name
  address_prefixes                                  = ["10.2.0.0/28"]
  enforce_private_link_endpoint_network_policies    = false
}

resource "azurerm_subnet_network_security_group_association" "asso_proxyout_nsg_subnet" {
  subnet_id                 = azurerm_subnet.proxyout_subnet.id
  network_security_group_id = azurerm_network_security_group.proxyout_nsg.id
}

################# Create Virtual Machine #################################################

resource "azurerm_network_interface" "proxyout1_vm_nic" {
  name                  = "proxyout1-vm-nic"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.proxyout_vnet.location

  enable_accelerated_networking = false
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ip-proxyout1-vm-config"
    subnet_id                     = azurerm_subnet.proxyout_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "proxyout1_vm" {
  name                  = "proxyout1-vm"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.proxyout_vnet.location
  network_interface_ids = [azurerm_network_interface.proxyout1_vm_nic.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  os_disk {
    name                 = "proxyout1-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }

  disable_password_authentication = false

  admin_username = "cicd"
  admin_password = var.vm_admin_password

  admin_ssh_key {
    username   = "cicd"
    public_key = var.vm_public_key
  }

  boot_diagnostics {
    storage_account_uri = var.france_central_boot_diagnostics_uri
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "asso_nic_backendpool_proxyout1" {
  network_interface_id    = azurerm_network_interface.proxyout1_vm_nic.id
  ip_configuration_name   = "ip-proxyout1-vm-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.proxyout_backend_pool.id
}

resource "azurerm_network_interface" "proxyout2_vm_nic" {
  name                  = "proxyout2-vm-nic"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.proxyout_vnet.location

  enable_accelerated_networking = false
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ip-proxyout2-vm-config"
    subnet_id                     = azurerm_subnet.proxyout_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "proxyout2_vm" {
  name                  = "proxyout2-vm"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.proxyout_vnet.location
  network_interface_ids = [azurerm_network_interface.proxyout2_vm_nic.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  os_disk {
    name                 = "proxyout2-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }

  disable_password_authentication = false

  admin_username = "cicd"
  admin_password = var.vm_admin_password

  admin_ssh_key {
    username   = "cicd"
    public_key = var.vm_public_key
  }

  boot_diagnostics {
    storage_account_uri = var.france_central_boot_diagnostics_uri
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "asso_nic_backendpool_proxyout2" {
  network_interface_id    = azurerm_network_interface.proxyout2_vm_nic.id
  ip_configuration_name   = "ip-proxyout2-vm-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.proxyout_backend_pool.id
}