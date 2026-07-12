# ─────────────────────────────────────────────────────────────────────────────
# User Assigned Managed Identity
# Scoped to resource group — never subscription level
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_user_assigned_identity" "uami" {
  name                = var.uami_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# ─────────────────────────────────────────────────────────────────────────────
# Key Vault
# RBAC mode — no access policies
# Public access disabled — private endpoint only
# Purge protection — prevents accidental permanent deletion
# Test
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  purge_protection_enabled      = true
  soft_delete_retention_days    = var.soft_delete_retention_days
  public_network_access_enabled = false
  tags                          = var.tags
}

# ─────────────────────────────────────────────────────────────────────────────
# Private DNS Zone
# One zone per workload environment
# Links to spoke VNet so DNS resolves internally
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv" {
  name                  = "dns-link-kv-${var.key_vault_name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.kv.name
  virtual_network_id    = var.spoke_vnet_id
  registration_enabled  = false
  tags                  = var.tags
}

# ─────────────────────────────────────────────────────────────────────────────
# Private Endpoint
# Lands in snet-pe subnet
# DNS zone group auto-registers the A record
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_private_endpoint" "kv" {
  name                = "pe-${var.key_vault_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.pe_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${var.key_vault_name}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group-kv"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }
}

# ─────────────────────────────────────────────────────────────────────────────
# Role Assignment — UAMI gets Key Vault Secrets User
# Least privilege — read secrets only, cannot manage keys or certificates
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_role_assignment" "uami_kv_secrets_user" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.uami.principal_id
}