# Project Specific Details

brand       = "Ingenovis"
environment = "Development"
project     = "Platform"
location    = "eastus"


# Project Specific Short Names

brand_short_name       = "ing"
environment_short_name = "dev"
project_short_name     = "pf"
location_short_name    = "eus"


# Vnet Address Spaces

hub_vnet_cidr = "10.72.0.0/20"


subnets = {
  "AzureFirewallSubnet" = { cidr = "10.72.0.0/26" }
  "AzureBastionSubnet"  = { cidr = "10.72.0.64/26" }
  "GatewaySubnet"       = { cidr = "10.72.0.128/27" }
  "snet-hub-mgmt"       = { cidr = "10.72.0.160/28" }
  "snet-hub-aks"        = { cidr = "10.72.2.0/23" }
  "snet-hub-pe"         = { cidr = "10.72.4.0/26" }
}




