locals {

  prefix = join("-", [
    var.brand_short_name,
    var.project_short_name,
    var.environment_short_name,
    var.location_short_name
  ])

  # Resource Naming
  resource_group_name = "rg-${local.prefix}-platform"
  vnet_name = "vnet-${local.prefix}-"


  # IP ADDRESS PLAN
  supernet = "10.72.0.0/16"

  vnet_cidr = "10.72.0.0/20"

  tags = {
    brand       = var.brand
    environment = var.environment   
    project     = var.project
    managed_by  = "Terraform"
  }
}
