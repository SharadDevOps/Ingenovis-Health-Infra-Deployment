module "resource_group" {
  source              = "../../../modules/resource-group"
  resource_group_name = local.resource_group_name
  location            = var.location

  tags = local.tags
}

module "hub_networking" {
  source              = "../../../modules/hub-networking"
  vnet_name           = local.vnet_name
  resource_group_name = module.resource_group.resource_group_name
  vnet_address_space  = [var.hub_vnet_cidr]
  location            = var.location
  subnets             = var.subnets

  tags = local.tags
}


