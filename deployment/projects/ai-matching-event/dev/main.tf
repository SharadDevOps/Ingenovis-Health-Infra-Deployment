data "azurerm_client_config" "current" {}

data "terraform_remote_state" "hub" {
  backend = "remote"
  config = {
    organization = "SharadDevops"
    workspaces = {
      name = "Ingenovis-Platform"
    }
  }
}

data "terraform_remote_state" "spoke" {
  backend = "remote"
  config = {
    organization = "saxenasharad-org"
    workspaces = {
      name = "ingenovis-ai-matching-event-dev"
    }
  }
}

# Resource Group Definition
module "resource_group" {
  source              = "../../../modules/resource-group"
  resource_group_name = local.resource_group_name
  location            = var.location
  tags                = local.tags
}


module "spoke_networking" {
  source              = "../../../modules/spoke-networking"
  vnet_name           = local.vnet_name
  resource_group_name = module.resource_group.resource_group_name
  vnet_address_space  = [var.spoke_vnet_cidr]
  location            = var.location
  tags                = local.tags
  subnets             = var.subnets

  hub_vnet_id             = data.terraform_remote_state.hub.outputs.vnet_id
  hub_vnet_name           = data.terraform_remote_state.hub.outputs.vnet_name
  hub_resource_group_name = data.terraform_remote_state.hub.outputs.resource_group_name
}

module "identity" {
  source              = "../../../modules/identity"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  uami_name           = "uami-${local.prefix}"
  key_vault_name      = "kv-${local.prefix}"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  pe_subnet_id        = data.terraform_remote_state.spoke.outputs.subnet_ids["snet-pe"]
  spoke_vnet_id       = data.terraform_remote_state.spoke.outputs.vnet_id
  tags                = local.tags
}

