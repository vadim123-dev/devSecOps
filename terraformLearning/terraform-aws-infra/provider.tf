terraform {
    required_version = ">= 1.6.0"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"    # locks to 5.x, allows patch updates only not moving to 6.0
        }
    }
}



provider "aws" {
    region = var.aws_region
}