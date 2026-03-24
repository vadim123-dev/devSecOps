terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


#Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}



data "aws_vpc" "prod-vpc" {
  filter {
    name   = "tag:Name"
    values = ["production-vpc"]
  }
}


data "aws_subnets" "private" {
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Tier"
    values = ["Public"] 
  }
}

output "found_vpc_id" {
  value = data.aws_vpc.prod-vpc
}


output "found_private_subnets" {
  value = data.aws_subnets.private
}

output "found_private_sub_1" {
  value = data.aws_subnets.private.ids[0]
}

