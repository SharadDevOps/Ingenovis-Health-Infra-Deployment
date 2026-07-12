output "vnet_id" {
  description = "Id of Virtual Network"
  value       = module.hub_networking.vnet_id
}

output "vnet_name" {
  description = "Name of Virtual Network"
  value       = module.hub_networking.vnet_name
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.hub_networking.resource_group_name
}