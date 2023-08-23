terraform {
 required_providers {
  aws = {
   source = "hashicorp/aws"
  }
 }
}

provider "aws" {
  region = var.primary_region
}


provider "aws" {
   region = var.failover_region
   alias  = "failover"
}  