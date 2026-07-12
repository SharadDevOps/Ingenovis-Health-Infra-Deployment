output "subnet_ids" {
  value = module.spoke_networking.subnet_ids
}

output "vnet_id" {
  value = module.spoke_networking.vnet_id
}

output "uami_id" {
  value = module.identity.uami_id
}

output "uami_client_id" {
  value = module.identity.uami_client_id
}

output "key_vault_id" {
  value = module.identity.key_vault_id
}

output "key_vault_uri" {
  value = module.identity.key_vault_uri
}