

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
  type    = string
  default = "Terraform"
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


variable "spoke_vnet_cidr" {
  type = string
  validation {
    condition     = can(cidrhost(var.spoke_vnet_cidr, 0))
    error_message = "spoke_vnet_cidr must be a valid CIDR block."
  }
}

variable "subnets" {
  description = "Spoke subnet configuration"
  type = map(object({
    cidr = string
  }))
}

# variable "tags" {
#   description = "A map of tags to assign to the resource group."
#   type        = map(string)
#   default     = {}
# }
