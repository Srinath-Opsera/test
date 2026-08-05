output "subnet_id" {
  description = "ID of the subnet."
  value       = aws_subnet.this.id
}

output "subnet_arn" {
  description = "ARN of the subnet."
  value       = aws_subnet.this.arn
}

output "subnet_cidr_block" {
  description = "CIDR block of the subnet."
  value       = aws_subnet.this.cidr_block
}

output "route_table_id" {
  description = "ID of the route table (created or associated)."
  value       = var.create_route_table ? aws_route_table.this[0].id : var.route_table_id
}

output "availability_zone" {
  description = "Availability zone of the subnet."
  value       = aws_subnet.this.availability_zone
}
