variable "public_subnet_ids" { type = list(string) }

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "public_sg_id"     { type = string }
variable "key_name"            {
  type    = string
  default = null   # optional: only needed for SSH key auth
}
variable "project_name"     { type = string }
variable "environment"      { type = string }

variable "efs_id"         { type = string }
variable "s3_object_url"  { 
  type        = string
  description = "Full URL to the S3 object to embed in index.html"
}

variable "efs_mount_ip"   { type = string }
