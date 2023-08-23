terraform {
  backend "s3" {
    bucket = "lifebit1"
    key    = "app2/terraform.tfstate"
    region = "eu-west-1"
  }
}