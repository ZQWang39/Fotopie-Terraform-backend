
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
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}