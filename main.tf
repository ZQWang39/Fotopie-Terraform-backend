terraform {
  required_version = ">= 0.12"
  required_providers {
     aws = {
      source = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  backend "s3" {
        # bucket = "fotopie-statefile-backend"
        # key = "terraform-uat.tfstate"
        # region = "ap-southeast-2"
    }
}

provider "aws" {
     
}
#Filter the azs
data "aws_availability_zones" "azs"{

}