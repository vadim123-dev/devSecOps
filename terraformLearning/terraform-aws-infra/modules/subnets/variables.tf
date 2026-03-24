variable "project_name"          { type = string }
variable "environment"           { type = string }
variable "vpc_id"                { type = string }
variable "internet_gateway_id"   { type = string }
variable "public_subnet_cidrs"   { type = list(string) }
variable "private_subnet_cidrs"  { type = list(string) }
variable "availability_zones"    { type = list(string) }