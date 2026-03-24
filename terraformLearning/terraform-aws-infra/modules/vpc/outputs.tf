output "vpc_id" {
    description = "The VPC ID"
    value       = aws_vpc.this.id
}

output "internet_gateway_id" {
    description = "the IGW ID"
    value       = aws_intenet_gateway.this.id
}