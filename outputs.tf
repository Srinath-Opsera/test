output "log_group_names" {
  description = "Map of log group keys to their names"
  value       = module.aws_cloudwatch.log_group_names
}

output "log_group_arns" {
  description = "Map of log group keys to their ARNs"
  value       = module.aws_cloudwatch.log_group_arns
}

output "role_arn" {
  description = "ARN of the IAM role"
  value       = module.terraform_aws_iam_role.role_arn
}

output "role_name" {
  description = "Name of the IAM role"
  value       = module.terraform_aws_iam_role.role_name
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.terraform_aws_security_group.security_group_id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = module.terraform_aws_security_group.security_group_arn
}

output "repository_name" {
  description = "ECR repository name"
  value       = module.aws_ecr_repository.repository_name
}

output "repository_arn" {
  description = "ECR repository ARN"
  value       = module.aws_ecr_repository.repository_arn
}

output "repository_url" {
  description = "ECR repository URL"
  value       = module.aws_ecr_repository.repository_url
}

output "function_arn" {
  description = "ARN of the Lambda function"
  value       = module.aws_lambda_function.function_arn
}

output "function_name" {
  description = "Name of the Lambda function"
  value       = module.aws_lambda_function.function_name
}

output "function_invoke_arn" {
  description = "ARN used to invoke the Lambda function"
  value       = module.aws_lambda_function.function_invoke_arn
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = module.aws_secrets_manager_secret.secret_arn
}

output "secret_name" {
  description = "Name of the Secrets Manager secret"
  value       = module.aws_secrets_manager_secret.secret_name
}

output "cross_account_s3_policy_arn" {
  description = "ARN of the cross-account S3 IAM policy"
  value       = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}
