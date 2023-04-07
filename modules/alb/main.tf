resource "aws_lb" "fotopie_alb" {
  name               = var.fotopieAlb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
  tags = {
    Environment = var.environment
  }
}

# //Use data resource to get `zone_id`
# data "aws_route53_zone" "fotopie" {
#   name         = "uat.fotopie.net"
# }

# resource "aws_route53_record" "attacheAlbDNS" {
#   zone_id = data.aws_route53_zone.fotopie.zone_id
#   name    = "api.${data.aws_route53_zone.fotopie.name}"
#   type    = "A"
#   alias {
#     name                   = aws_lb.fotopie_alb.dns_name
#     zone_id                = aws_lb.fotopie_alb.zone_id
#     evaluate_target_health = true
#   }
# }  

resource "aws_lb_target_group" "fotopie_target_group" {
  name        = var.fotopie_target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

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
    Environment = var.environment
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
    Environment = var.environment
  }
}