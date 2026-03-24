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

module "aws_ec2_image_module" {
    source = "./mod1"

    ami_filter_param = "${var.ami_filter_param}"
    project_tag = "${var.project_tag}"
}


# 5. Output (Optional: Print the ID to the terminal)
output "found_ami" {
  value = module.aws_ec2_image_module.aws_instance
}