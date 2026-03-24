variable "project_name"            { type = string }
variable "environment"             { type = string }
variable "region" {
    type    = string
    default = "us-east-1"
}

variable "public_subnet_cidrs" { type = list(string)}
variable "availability_zones"  { type = list(string)}
variable "vpc_cidr"            { type = string }
variable "instance_type"       { type = string }