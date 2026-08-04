output "log_group_names" {
  description = "Map of log group keys to their names"
  value       = module.cloudwatch_log_group.log_group_names
}

output "log_group_arns" {
  description = "Map of log group keys to their ARNs"
  value       = module.cloudwatch_log_group.log_group_arns
}

output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_arn
}

output "lambda_execution_role_name" {
  description = "Name of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_name
}

output "lambda_execution_role_id" {
  description = "Stable ID of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_id
}

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

output "s3_cross_account_policy_arn" {
  description = "ARN of the cross-account S3 IAM policy attached to the Lambda role"
  value       = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}

output "secrets_manager_policy_arn" {
  description = "ARN of the Secrets Manager IAM policy attached to the Lambda role"
  value       = aws_iam_policy.cross_account_secretsmanager_affinity_test_secrets_access.arn
}
