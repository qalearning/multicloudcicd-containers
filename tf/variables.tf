variable "container_app_name" {
  type    = string
  default = "containerdemoapp"
}

# variable "resource_group_name" {
#   type    = string
#   default = "container-demo-rg"
# }

variable "resource_group_location" {
  type    = string
  default = "uksouth"
}

variable "ecs_cluster_name" {
  type    = string
  default = "codebuild-demo-cluster"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}