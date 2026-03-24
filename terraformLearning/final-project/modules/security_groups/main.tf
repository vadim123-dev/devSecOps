# ─── PUBLIC INSTANCE SG ──────────────────────────────────────
resource "aws_security_group" "public_ec2" {
  name        = "${var.project_name}-sg-public-ec2"
  description = "Security group for public EC2 instances"
  vpc_id      = var.vpc_id

  # Allow SSH from anywhere (tighten this to your IP in real projects!)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Outbound NFS to EFS
  egress {
    description = "NFS to EFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"   # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg-public-ec2"
    Environment = var.environment
  }
}

# ─── PRIVATE INSTANCE SG ─────────────────────────────────────
resource "aws_security_group" "private_ec2" {
  name        = "${var.project_name}-sg-private-ec2"
  description = "Security group for private EC2 instances"
  vpc_id      = var.vpc_id

  # Only allow SSH from within the VPC (from the public instances)
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Allow all outbound (to reach NAT GW for updates)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg-private-ec2"
    Environment = var.environment
  }
}



# ─── SECURITY GROUP FOR EFS ──────────────────────────────────
# EFS communicates over NFS — port 2049
resource "aws_security_group" "efs" {
  name        = "${var.project_name}-sg-efs"
  description = "Allow NFS traffic from EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "NFS from EC2"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2.id]  # only EC2 instances can talk to EFS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg-efs"
    Environment = var.environment
  }
}