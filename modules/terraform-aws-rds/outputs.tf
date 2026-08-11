output "db_instance_address" {
  description = "Hostname of the RDS instance."
  value       = aws_db_instance.this.address
}

output "db_instance_endpoint" {
  description = "Connection endpoint (host:port)."
  value       = aws_db_instance.this.endpoint
}

output "db_instance_port" {
  description = "Database port."
  value       = aws_db_instance.this.port
}

output "db_instance_arn" {
  description = "ARN of the RDS instance."
  value       = aws_db_instance.this.arn
}

output "db_instance_id" {
  description = "RDS instance ID."
  value       = aws_db_instance.this.id
}
