# ---- Dynamic AMI Lookup
# ---- Fetches the latest Amazon Linux 2023 AMI for our region

data "aws_ami" "amazon_linux" {
    most_recent   = true
    owners        = ["amazon"]

    filter {
        name      = "virtualization-type"
        values    = ["hvm"]
    }

    filter {
        name   = "name"
        values = ["al2023-ami-*-x86_64"]
  }
}


# 1. Create the Role
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# 2. Attach SSM policy to the Role
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# 3. Create Instance Profile (wrapper that lets EC2 use the role)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}



resource "aws_instance" "public-A" {
    ami                    = data.aws_ami.amazon_linux.id
    instance_type          = var.instance_type
    subnet_id              = var.public_subnet_ids[0]
    vpc_security_group_ids = [var.public_sg_id]
    key_name               = var.key_name
    iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name


    # templatefile() lets us inject Terraform variables into the script
    user_data = templatefile("${path.module}/user_data_A.sh", {
    efs_id         = var.efs_id
    efs_mount_ip   = var.efs_mount_ip
    s3_object_url  = var.s3_object_url
  })

    # Wait for EFS mount targets to be ready before creating instances


    tags = {
         Name         = "${var.project_name}-ec2-A"
         Environment  =  var.environment
    }

}


resource "aws_instance" "public-B" {
    ami                    = data.aws_ami.amazon_linux.id
    instance_type          = var.instance_type
    subnet_id              = var.public_subnet_ids[1]
    vpc_security_group_ids = [var.public_sg_id]
    key_name               = var.key_name
    iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

    user_data = templatefile("${path.module}/user_data_B.sh", {
        efs_id         = var.efs_id
        efs_mount_ip   = var.efs_mount_ip
    })
 
    tags = {
        Name         = "${var.project_name}-ec2-B"
        Environment  =  var.environment
    }


}

