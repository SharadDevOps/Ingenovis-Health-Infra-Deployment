data "terraform_remote_state" "hub" {
  backend = "remote"
  config = {
    organization = "SharadDevops"
    workspaces = {
      name = "Ingenovis-Platform"
    }
  }
}

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

