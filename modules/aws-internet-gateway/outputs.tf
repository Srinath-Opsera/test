output "id" {
  description = "The ID of the Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "arn" {
  description = "The ARN of the Internet Gateway."
  value       = aws_internet_gateway.this.arn
}

output "vpc_id" {
  description = "The ID of the VPC to which the Internet Gateway is attached."
  value       = aws_internet_gateway.this.vpc_id
}

output "name" {
  description = "The name assigned to the Internet Gateway."
  value       = var.name
}
