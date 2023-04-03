terraform {
  backend "s3" {
    bucket = "fotopie-statefile-backend"
    key    = "terraform-prod.tfstate"
    region = "ap-southeast-2"
  }
}
