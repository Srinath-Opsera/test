# ============================================================
# CloudWatch outputs
# ============================================================
output "log_group_names" {
  description = "Map of log group keys to their names"
  value       = module.cloudwatch.log_group_names
}

output "log_group_arns" {
  description = "Map of log group keys to their ARNs"
  value       = module.cloudwatch.log_group_arns
}

# ============================================================
# Lambda Execution IAM Role outputs
# ============================================================
output "lambda_role_arn" {
  description = "ARN of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_arn
}

output "lambda_role_name" {
  description = "Name of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_name
}

output "lambda_role_id" {
  description = "Stable ID of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_id
}

# ============================================================
# Lambda Security Group outputs
# ============================================================
output "lambda_security_group_id" {
  description = "ID of the Lambda security group"
  value       = module.lambda_security_group.security_group_id
}

output "lambda_security_group_arn" {
  description = "ARN of the Lambda security group"
  value       = module.lambda_security_group.security_group_arn
}

output "lambda_security_group_name" {
  description = "Name of the Lambda security group"
  value       = module.lambda_security_group.security_group_name
}
