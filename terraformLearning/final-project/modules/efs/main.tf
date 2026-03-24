# ─── EFS FILESYSTEM ──────────────────────────────────────────
resource "aws_efs_file_system" "this" {
  creation_token   = "${var.project_name}-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  # Encrypt data at rest — always a good practice
  encrypted = true

  tags = {
    Name        = "${var.project_name}-efs"
    Environment = var.environment
  }
}

# ─── MOUNT TARGETS ───────────────────────────────────────────
# One mount target per subnet — this is what EC2 instances
# actually connect to. EFS routes NFS traffic through these.
resource "aws_efs_mount_target" "this" {
  count           = length(var.public_subnet_ids)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.public_subnet_ids[count.index]
  security_groups = [var.efs_sec_group_id]
}