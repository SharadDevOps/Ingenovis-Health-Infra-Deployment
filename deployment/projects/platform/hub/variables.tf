variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}

variable "brand" {
  description = "The brand to assign to the resource group."
  type        = string
}

variable "environment" {
  description = "The environment to assign to the resource group."
  type        = string
}

variable "project" {
  description = "The project to assign to the resource group."
  type        = string
}

variable "managed_by" {
  description = "Tool used to manage this resource"
  type        = string
  default     = "Terraform"
}

variable "brand_short_name" {
  description = "The brand_short_name to assign to the resource group."
  type        = string
}

variable "environment_short_name" {
  description = "The environment_short_name to assign to the resource group."
  type        = string
}

variable "project_short_name" {
  description = "The project_short_name to assign to the resource group."
  type        = string
}

variable "location_short_name" {
  description = "The location short name to assign to the resource group."
  type        = string
}

variable "hub_vnet_cidr" {
  description = "Address space of Hub Vnet added"
  type        = string
}

variable "subnets" {
  description = "Hub subnet configuration"
  type = map(object({
    cidr = string
  }))
}

# variable "tags" {
#   description = "A map of tags to assign to the resource group."
#   type        = map(string)
#   default     = {}
# }
