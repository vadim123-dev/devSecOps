terraform {
    required_version = ">= 1.6.0"


    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}



provider "aws" {
    region = var.region
}

module "networking" {
    source              = "./modules/networking"

    project_name        = var.project_name
    vpc_cidr            = var.vpc_cidr
    environment         = var.environment
    public_subnet_cidrs = var.public_subnet_cidrs
    availability_zones  = var.availability_zones
}



module "storage" {
    source              = "./modules/storage"

    project_name        = var.project_name
    environment         = var.environment
    aws_region          = var.region
}


module "security" {
    source = "./modules/security_groups"

    project_name        = var.project_name
    environment         = var.environment
    vpc_id              = module.networking.vpc_id
    vpc_cidr            = var.vpc_cidr

}

module "efs" {
    source = "./modules/efs"

    efs_sec_group_id    = module.security.efs_sec_group_id
    project_name        = var.project_name
    environment         = var.environment
    vpc_id              = module.networking.vpc_id
    public_subnet_ids   = module.networking.public_subnet_ids
}

module "ec2" {
    source = "./modules/compute"
    
    depends_on = [module.efs] 
    
    project_name        = var.project_name
    public_subnet_ids   = module.networking.public_subnet_ids
    instance_type       = var.instance_type
    public_sg_id        = module.security.public_ec2_sg_id
    environment         = var.environment
    
    # Pass EFS values down to EC2
    efs_id         = module.efs.efs_id
    efs_mount_ip   = module.efs.efs_mount_target_ip
    s3_object_url  = module.storage.s3_object_url
}