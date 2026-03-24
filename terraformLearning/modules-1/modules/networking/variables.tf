variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "AZ for the subnet"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names/tags"
  type        = string
}