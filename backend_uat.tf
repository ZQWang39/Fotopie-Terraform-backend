terraform {
  backend "s3" {
    bucket = "fotopie-statefile-backend"
    key    = "terraform-uat.tfstate"
    region = "ap-southeast-2"
  }
}
