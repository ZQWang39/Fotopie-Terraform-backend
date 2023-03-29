resource "aws_lb" "fotopie_alb" {
  name               = "fotopieAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb-security-group.security_group_id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = true
  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "fotopie_target_group" {
  name        = "fotopieTargetGroup"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
    path                = "/api/user/"
    interval            = 20
  }
  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.fotopie_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fotopie_target_group.arn
  }
  tags = {
    Environment = "dev"
  }
}