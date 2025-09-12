data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

resource "aws_ecs_task_definition" "ecs_fargate_task" {
  container_definitions = jsonencode([{
    essential = true,
    image     = "public.ecr.aws/bitnami/apache:2.4",

    name         = "codebuild-demo",
    portMappings = [{ containerPort = 8080 }],
  }])
  cpu                      = 256
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = data.aws_iam_role.ecs_task_role.arn
  family                   = "codebuild-demo-tasks"
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

}

resource "aws_ecs_service" "ecs_fargate_service" {
  cluster                = module.ecs.cluster_id
  desired_count          = 1
  enable_execute_command = true
  launch_type            = "FARGATE"
  name                   = "codebuild-demo-service"
  task_definition        = resource.aws_ecs_task_definition.ecs_fargate_task.arn

  lifecycle {
    ignore_changes = [desired_count]
  }

  load_balancer {
    container_name   = "codebuild-demo"
    container_port   = 8080
    target_group_arn = module.alb.target_group_arns[0]
  }

  network_configuration {
    security_groups = [resource.aws_security_group.ecs_task_security_group.id]
    subnets         = module.vpc.private_subnets
  }
}

resource "aws_security_group" "ecs_task_security_group" {
  vpc_id = module.vpc.vpc_id
  ingress = [
    {
      security_groups  = [module.alb.security_group_id]
      description      = "Allow8080FromALB"
      from_port        = 8080
      protocol         = "TCP"
      to_port          = 8080
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = true
    }
  ]
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "AllowAllOutbound"
      from_port        = 0
      protocol         = "all"
      to_port          = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]
}
