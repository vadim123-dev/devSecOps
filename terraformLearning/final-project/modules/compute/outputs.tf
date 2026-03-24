
output "instance_a_url" {
  value = "http://${aws_instance.public-A.public_dns}"
}

output "instance_b_url" {
  value = "http://${aws_instance.public-B.public_dns}"
}