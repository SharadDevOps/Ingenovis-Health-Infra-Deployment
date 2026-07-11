locals {

  prefix = join("-", [
    var.brand_short_name,
    var.project_short_name,
    var.environment_short_name,
    var.location_short_name
  ])

  resource_group_name = "rg-${local.prefix}"
  vnet_name           = "vnet-${local.prefix}-spoke"

  tags = {
    brand       = var.brand
    environment = var.environment
    project     = var.project
    managed_by  = var.managed_by
  }
}