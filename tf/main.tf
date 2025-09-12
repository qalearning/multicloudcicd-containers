module "aws" {
  source           = "./modules/aws"
  ecs_cluster_name = var.ecs_cluster_name
  aws_region       = var.aws_region
}

module "azure" {
  source                  = "./modules/azure"
  aca_name                = var.container_app_name
  resource_group_location = var.resource_group_location
}