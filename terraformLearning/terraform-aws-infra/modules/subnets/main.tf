
# -------- PUBLIC SUBNETS -------------------------------------
resource "aws_subnet" "public" {
    count              = length(var.public_subnet_cidrs)
    vpc_id             = var.vpc_id
    cidr_block         = var.public_subnet_cidrs[count.index]
    availability_zone  = var.availability_zones[count.index]

    # Instances launched here, automatically get a public IP
    map_public_ip_on_launch = true


    tags = {
        Name         = "${var.project_name}-public-${count.index + 1}"
        Environment  = var.environment
        Tier         = "public"
    }
}


# -------- PRIVATE SUBNETS -------------------------------------
resource "aws_subnet" "private" {
    count               = length(var.private_subnet_cidrs)
    vpc_id              = var.vpc_id
    
}