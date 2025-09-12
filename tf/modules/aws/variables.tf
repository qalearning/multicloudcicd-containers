variable "aws_region" {
  description = "AWS region to launch cluster into."
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository"
  default     = "mccicd-codebuild-demo"
}