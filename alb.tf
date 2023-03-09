resource "aws_lb" "fotopie_alb" {
  name               = "fotopieAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb-security-group.security_group_id]
  subnets            = var.default_subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "fotopie_target_group" {
  name        = "fotopieTargetGroup"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.default_vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = "/"
    interval            = 20
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
}