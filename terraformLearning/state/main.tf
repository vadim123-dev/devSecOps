terraform {
    required_providers {
        aws = { 
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
  region = "us-east-1" # Change this to your preferred region
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_security_group" "state_exercise" {
  name        = "terraform-state-demo"
  description = "A resource to practice state commands"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "StateDemo"
  }
}

output "security_group_id" {
  value = aws_security_group.state_exercise.id
}