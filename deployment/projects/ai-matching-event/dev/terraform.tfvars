brand       = "Ingenovis"
environment = "Development"
project     = "AI-Matching-event"
location    = "eastus"

brand_short_name       = "ing"
project_short_name     = "aime"
environment_short_name = "dev"
location_short_name    = "eus"

spoke_vnet_cidr = "10.72.64.0/22"

subnets = {
  "snet-aks"     = { cidr = "10.72.64.0/24" }
  "snet-pe"      = { cidr = "10.72.65.0/27" }
  "snet-ingress" = { cidr = "10.72.65.32/28" }
  "snet-mgmt"    = { cidr = "10.72.65.48/28" }
}