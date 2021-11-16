resource "azurerm_public_ip" "pip_bastion" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.hub_spoke_rg.name
  location            = azurerm_virtual_network.hub_vnet.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "bastion_nic" {
  name                  = "bastion-nic"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.hub_vnet.location

  enable_accelerated_networking = false

  ip_configuration {
    name                          = "ip-bastion-config"
    subnet_id                     = azurerm_subnet.hub_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip_bastion.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion_vm" {
  name                  = "bastion-vm"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.hub_vnet.location
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  os_disk {
    name                 = "bastion-os-disk"
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
}

resource "azurerm_network_interface" "accounting_vm_nic" {
  name                  = "accounting-vm-nic"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.spoke1_vnet.location

  enable_accelerated_networking = false

  ip_configuration {
    name                          = "ip-accounting-vm-config"
    subnet_id                     = azurerm_subnet.spoke1_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "accounting_vm" {
  name                  = "accounting-vm"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.spoke1_vnet.location
  network_interface_ids = [azurerm_network_interface.accounting_vm_nic.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  os_disk {
    name                 = "accounting-vm-os-disk"
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
    storage_account_uri = var.west_europe_boot_diagnostics_uri
  }
}

resource "azurerm_network_interface" "security_vm_nic" {
  name                  = "security-vm-nic"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.spoke2_vnet.location

  enable_accelerated_networking = false

  ip_configuration {
    name                          = "ip-security-vm-config"
    subnet_id                     = azurerm_subnet.spoke2_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "security_vm" {
  name                  = "security-vm"
  resource_group_name   = azurerm_resource_group.hub_spoke_rg.name
  location              = azurerm_virtual_network.spoke2_vnet.location
  network_interface_ids = [azurerm_network_interface.security_vm_nic.id]
  size                  = var.vm_size

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }

  os_disk {
    name                 = "security-vm-os-disk"
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
    storage_account_uri = var.north_europe_boot_diagnostics_uri
  }
}