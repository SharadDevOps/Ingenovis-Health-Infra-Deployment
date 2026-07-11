variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
}

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

variable "vnet_hub_name" {
  description = "Name of Vnet Hub"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource group."
  type        = map(string)
  default     = {}
}
