terraform {
  backend "s3" {
    bucket = "lifebit1"
    key    = "app/terraform.tfstate"
    region = "eu-west-1"
  }
}