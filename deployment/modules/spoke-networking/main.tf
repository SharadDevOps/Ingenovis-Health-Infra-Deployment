resource "azurerm_virtual_network" "spoke" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  location            = var.location
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.cidr]
}

# Spoke → Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-${var.vnet_name}-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}


# Hub → Spoke (managed from spoke state, lives in hub resource group)
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-${var.vnet_name}"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}