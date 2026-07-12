output "uami_id" {
  description = "Resource ID of the UAMI — used for AKS, ACR, Cosmos assignments in later layers"
  value       = azurerm_user_assigned_identity.uami.id
}

output "uami_principal_id" {
  description = "Principal ID of the UAMI — used for role assignments"
  value       = azurerm_user_assigned_identity.uami.principal_id
}

output "uami_client_id" {
  description = "Client ID of the UAMI — used in AKS workload identity config"
  value       = azurerm_user_assigned_identity.uami.client_id
}

output "key_vault_id" {
  description = "Resource ID of the Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_uri" {
  description = "URI of the Key Vault — used by applications to read secrets"
  value       = azurerm_key_vault.kv.vault_uri
}