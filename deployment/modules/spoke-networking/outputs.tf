output "vnet_id" {
    value = azurerm_virtual_network.hub.id
}

output "vnet_name" {
    value = azurerm_virtual_network.hub.name
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "subnet_ids" {
  value = {
    for name, subnet in azurerm_subnet.subnets : name => subnet.id
  }
}
