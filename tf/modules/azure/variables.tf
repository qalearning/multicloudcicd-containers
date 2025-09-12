variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
  default     = "uksouth"
}

# variable "resource_group_name" {
#   type        = string
#   description = "Resource Group name."
# }

variable "aca_name" {
  type        = string
  description = "Azure Container App name."
  default     = "containerapp-demo"
}