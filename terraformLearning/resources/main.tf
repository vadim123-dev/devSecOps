terraform {
    required_providers {
        aws = { 
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

module "mod1" {
    source = "./mod1"

    s3_name_prefix = "apelsin-1"
}

module "mod2" {
    source = "./mod1"

    s3_name_prefix = "banan-2"
}