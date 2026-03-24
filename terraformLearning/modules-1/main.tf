terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "./modules/networking"   # path to your module folder

  # These match the variable names in modules/networking/variables.tf
  vpc_cidr            = "10.0.0.0/16"
  private_subnet_cidr = "10.0.1.0/24"
  availability_zone   = "us-east-1a"
  name_prefix         = "my-app"
}