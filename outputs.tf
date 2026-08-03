# ============================================================
# CloudWatch Log Group outputs
# ============================================================
output "log_group_names" {
  description = "Map of log group keys to their names"
  value       = module.cloudwatch_log_group.log_group_names
}

output "log_group_arns" {
  description = "Map of log group keys to their ARNs"
  value       = module.cloudwatch_log_group.log_group_arns
}

# ============================================================
# ECR Repository outputs
# ============================================================
output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.ecr_repository.repository_arn
}

output "ecr_repository_url" {
  description = "URL of the ECR repository (used by CI/CD to push images)"
  value       = module.ecr_repository.repository_url
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr_repository.repository_name
}

# ============================================================
# IAM Role outputs
# ============================================================
output "lambda_role_arn" {
  description = "ARN of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_arn
}

output "lambda_role_name" {
  description = "Name of the Lambda execution IAM role"
  value       = module.lambda_execution_role.role_name
}

# ============================================================
# Security Group outputs
# ============================================================
output "lambda_security_group_id" {
  description = "ID of the Lambda security group"
  value       = module.lambda_security_group.security_group_id
}

output "lambda_security_group_arn" {
  description = "ARN of the Lambda security group"
  value       = module.lambda_security_group.security_group_arn
}

# ============================================================
# Lambda Function outputs
# ============================================================
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda_function.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda_function.function_arn
}

output "lambda_function_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = module.lambda_function.function_invoke_arn
}

output "lambda_function_version" {
  description = "Latest published version of the Lambda function"
  value       = module.lambda_function.function_version
}

output "lambda_function_last_modified" {
  description = "Date the Lambda function was last modified"
  value       = module.lambda_function.function_last_modified
}

# ============================================================
# Secrets Manager outputs
# ============================================================
output "secret_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = module.secrets_manager_secret.secret_arn
}

output "secret_name" {
  description = "Name of the Secrets Manager secret"
  value       = module.secrets_manager_secret.secret_name
}

output "secret_version_id" {
  description = "Version ID of the Secrets Manager secret"
  value       = module.secrets_manager_secret.secret_version_id
}

# ============================================================
# Cross-account IAM policy outputs
# ============================================================
output "cross_account_s3_policy_arn" {
  description = "ARN of the cross-account S3 access IAM policy"
  value       = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}
