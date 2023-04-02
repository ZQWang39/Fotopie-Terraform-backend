terraform {
  required_version = ">= 0.12"
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  backend "s3" {
        bucket = "fotopie-statefile-backend"
        key = var.terraform_state_file
        region = var.s3_region
    }
}

provider "aws" {
     
}
#Filter the azs
data "aws_availability_zones" "azs"{

}