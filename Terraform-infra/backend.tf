terraform {
  backend "s3" {
    bucket = "lifebitmain1"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}