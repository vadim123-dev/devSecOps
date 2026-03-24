output "efs_id" {
  description = "EFS filesystem ID (used in mount commands)"
  value       = aws_efs_file_system.this.id
}

output "efs_dns_name" {
  description = "EFS DNS name for mounting"
  value       = aws_efs_file_system.this.dns_name
}


# In modules/efs/outputs.tf
output "efs_mount_target_ip" {
  value = aws_efs_mount_target.this[0].ip_address
}