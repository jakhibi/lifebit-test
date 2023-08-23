terraform {
  backend "s3" {
    bucket = "lifebit1"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}