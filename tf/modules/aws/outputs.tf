output "aws_url" {
  value = "http://${module.alb.lb_dns_name}"
}

# output "task_uri" {
#   value = resource.ecs_fargate_task.task_definition
# }