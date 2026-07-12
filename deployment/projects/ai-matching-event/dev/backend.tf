terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  # Cloud Entry for State File
  cloud {
    organization = "SharadDevops"
    workspaces {
      name = "Ingenovis-AI-Matching-Event-Dev"
    }
  }
}

provider "azurerm" {
  features {}
}


