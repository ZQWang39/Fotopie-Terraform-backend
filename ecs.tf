module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.3"

  cluster_name = var.cluster_name
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_ecs_task_definition" "fotopie_task" {
  family = var.task_definition_family_name
  requires_compatibilities = var.irequires_compatibilities
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name      = var.image_name
      image     = var.image_uri
      cpu       = var.fargate_cpu
      memory    = var.fargate_memory
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "fotopie_service" {
  name            = var.ecs_service_name
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.fotopie_task.arn
  launch_type     = var.service_launch_type
  desired_count   = var.desired_tasks
  force_new_deployment = true

  network_configuration {
    security_groups  = [module.ecs-security-group.security_group_id]
    subnets          = module.vpc.public_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.fotopie_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}
