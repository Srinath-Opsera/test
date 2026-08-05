output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs."
  value       = aws_nat_gateway.this[*].id
}

output "nat_gateway_public_ips" {
  description = "List of public IP addresses associated with the NAT Gateways. Empty when connectivity_type is 'private'."
  value       = aws_nat_gateway.this[*].public_ip
}

output "nat_gateway_private_ips" {
  description = "List of private IP addresses associated with the NAT Gateways."
  value       = aws_nat_gateway.this[*].private_ip
}

output "eip_ids" {
  description = "List of Elastic IP IDs created by this module. Empty when create_eip is false or connectivity_type is 'private'."
  value       = aws_eip.this[*].id
}

output "eip_public_ips" {
  description = "List of Elastic IP public IP addresses created by this module. Empty when create_eip is false or connectivity_type is 'private'."
  value       = aws_eip.this[*].public_ip
}

output "nat_gateway_subnet_ids" {
  description = "List of subnet IDs in which the NAT Gateways were created."
  value       = aws_nat_gateway.this[*].subnet_id
}
