# module "resource_group" {
#   source              = "../../modules/resource-group"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   tags                = local.tags
# }

# module "hub_networking" {
#   source              = "../../../modules/hub-networking"
#   vnet_name           = local.vnet_hub_name
#   resource_group_name = module.resource_group.resource_group_name
#   vnet_address_space  = var.
#   location            = var.location
#   tags                = local.tags
# }


