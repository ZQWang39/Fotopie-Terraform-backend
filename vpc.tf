terraform {
  required_version = ">= 0.12"
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  backend "s3" {
        bucket = "fotopie-backend-state-file"
        key = "terraform.tfstate"
        region = "ap-southeast-2"
    }
}

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
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}