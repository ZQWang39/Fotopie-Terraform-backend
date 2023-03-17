# Using modules

module "alb-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  
  name        = "application-loadbalancer-security-group"
  description = "Inbound traffic port 80 from anywhere"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      description      = "Open prot80 to accept all external traffic"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = "0.0.0.0/0"
      ipv6_cidr_blocks = "::/0"
   }
  ]
}


module "ecs-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  
  name        = "ecs-service-security-group"
  description = "Inbound traffic from ApplicationLoadBalancerSG"
  vpc_id      = module.vpc.vpc_id
      
  ingress_with_source_security_group_id = [
    {
      description      = "Inbound traffic ApplicationLoadBalancerSG"
      from_port        = 0
      to_port          = 65535
      protocol         = "tcp"
      source_security_group_id  = module.alb-security-group.security_group_id
    }
  ]
  
  egress_with_cidr_blocks = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = "0.0.0.0/0"
      ipv6_cidr_blocks = "::/0"
   }
  ]
}

# use resources

# resource "aws_security_group" "fotopie_alb_sg" {
#   name        = var.fotopie_alb_sg
#   description = "Open 80 to accept all external traffic "
#   vpc_id      = module.vpc.vpc_id

#     ingress {
#     description      = "Open port 80 for FotoPie backend ALB"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "fotopie_backend_alb_sg"
#   }
# }

# resource "aws_security_group" "fotopie_ecs_service_sg" {
#   name        = var.fotopie_ecs_service_sg
#   description = "Only receive the traffic from fotopie_alb"
#   vpc_id      = module.vpc.vpc_id

#     ingress {
#     description      = "Only receive the traffic from fotopie_alb"
#     from_port        = 0
#     to_port          = 65535
#     protocol         = "tcp"
#     security_groups  = [aws_security_group.fotopie_alb_sg.id]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "fotopie_backend_ecs_sg"
#   }
# }
