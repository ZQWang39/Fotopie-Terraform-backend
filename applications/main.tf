
provider "aws" {
     
}
#Filter the azs
data "aws_availability_zones" "azs"{

}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = var.fotopie_vpc
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  create_igw = true
  enable_nat_gateway = true
  single_nat_gateway = var.single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Environment = var.environment
  }
}

module "FotoPie_sg" {
  source = "./modules/security_groups"
  application-loadbalancer-security-group = var.application-loadbalancer-security-group
  vpc_id = module.vpc.vpc_id
  environment = var.environment
  ecs-service-security-group = var.ecs-service-security-group
  grafana-security-group = var.grafana-security-group
  my_ip_address = var.my_ip_address
}

module "FotoPie_ecs_cluster" {
  source = "./modules/ecs"
  cluster_name = var.cluster_name
  environment = var.environment
  ecs-task-execution-role = var.ecs-task-execution-role
  ecr-policy-name = var.ecr-policy-name
  task_definition_family_name = var.task_definition_family_name
  irequires_compatibilities = var.irequires_compatibilities
  fargate_cpu = var.fargate_cpu
  fargate_memory = var.fargate_memory
  image_name = var.image_name
  image_uri = var.image_uri
  app_port = var.app_port
  ecs_service_name = var.ecs_service_name
  service_launch_type = var.service_launch_type
  desired_tasks = var.desired_tasks
  ecs_security_group_id = module.FotoPie_sg.ecs_security_group_id
  private_subnets = module.vpc.private_subnets
  fotopie_target_group_arn = module.FotoPie_alb.fotopie_target_group_arn
  container_name = var.container_name
  container_port = var.container_port
}

module "FotoPie_alb" {
  source = "./modules/alb"
  fotopieAlb_name = var.fotopieAlb_name
  alb_security_group_id = module.FotoPie_sg.alb_security_group_id
  public_subnets = module.vpc.public_subnets
  environment = var.environment
  fotopie_target_group_name = var.fotopie_target_group_name
  vpc_id = module.vpc.vpc_id
  
}

module "FotoPie_aws_grafana" {
  source = "./modules/aws_grafana"
  grafana_name = var.grafana_name
  grafana_security_group_id = module.FotoPie_sg.grafana_security_group_id
  private_subnets = module.vpc.private_subnets
  aws_group_id = var.aws_group_id
  aws_user_id = var.aws_user_id
  environment = var.environment
}