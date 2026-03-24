terraform {
    required_providers {
        aws = { 
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "${var.aws_region}"
}



resource "aws_s3_bucket" "first" {
    bucket = "${var.s3_bucket_name}"

    tags = {
        Name = "${var.s3_bucket_name}"
        Environment = "${var.project_tag}"
    }
}


