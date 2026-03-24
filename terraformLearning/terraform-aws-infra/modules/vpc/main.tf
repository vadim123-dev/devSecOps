resource "aws_vpc" "this" {
    cidr_block           = var.vpc_cidr
    enable_dns_support   = true        # requeired for EC2 hostname resolution
    enable_dns_hostnames = true        # requeired for public DNS names on EC2

    tags = {
        Name          = "${var.project_name}-vpc"
        Environment   =  var.environment
    }
}


resource "aws_intenet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name        = "${var.project_name}-igw"
        Environment = var.environment
    }
}