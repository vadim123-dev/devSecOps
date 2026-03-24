variable "project_name" {
    description  = "Prefix of the resouce names"
    type         =  string
}


variable "environment" {
    description  = "Environment tag dev,staging, prod"
    type         =  string
    default      =  "dev"
}


variable "vpc_cidr" {
    description  = "Cidr for this vpc"
    type         =  string
}

variable "public_subnet_cidrs"   { type = list(string) }
variable "availability_zones"    { type = list(string) }