output "iam_role_arn" {
  description = "ARN of the Lambda execution IAM role."
  value       = module.lambda_execution_role.role_arn
}

output "iam_role_name" {
  description = "Name of the Lambda execution IAM role."
  value       = module.lambda_execution_role.role_name
}

output "iam_role_id" {
  description = "Stable ID of the Lambda execution IAM role."
  value       = module.lambda_execution_role.role_id
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret."
  value       = module.affinity_test_secret.secret_arn
}

output "secret_name" {
  description = "Name of the Secrets Manager secret."
  value       = module.affinity_test_secret.secret_name
}

output "secret_id" {
  description = "ID (ARN) of the Secrets Manager secret."
  value       = module.affinity_test_secret.secret_id
}

output "secret_version_id" {
  description = "Version ID of the Secrets Manager secret."
  value       = module.affinity_test_secret.secret_version_id
}
