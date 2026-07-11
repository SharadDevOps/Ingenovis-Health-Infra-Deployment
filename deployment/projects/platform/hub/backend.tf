terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  cloud {
    organization = "SharadDevops"
    workspaces {
      name = "Ingenovis-Platform"
    }
  }
}

provider "azurerm" {
  features {}
}


