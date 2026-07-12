output "vnet_id" {
  value = azurerm_virtual_network.spoke.id
}

output "vnet_name" {
  value = azurerm_virtual_network.spoke.name
}

output "resource_group_name" {
  value = azurerm_virtual_network.spoke.resource_group_name
}

output "subnet_ids" {
  value = {
    for name, subnet in azurerm_subnet.subnets : name => subnet.id
  }
}
