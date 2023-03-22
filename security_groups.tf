
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

module "grafana-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  
  name        = "grafana-security-group"
  description = "open port 80/443 for inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      description      = "Open prot80 to accept all external traffic"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = "0.0.0.0/0"
    },
     {
      description      = "Open prot443 to accept all external traffic"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = "0.0.0.0/0"
    }, 
    {
      description      = "Open port 22 to my IP address"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = var.my_ip_address
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
