output "iam_policy_arn" {
  description = "ARN of the IAM policy for Secrets Manager access"
  value       = aws_iam_policy.secrets_manager_access.arn
}

output "iam_policy_name" {
  description = "Name of the IAM policy for Secrets Manager access"
  value       = aws_iam_policy.secrets_manager_access.name
}

output "secret_id" {
  description = "The ID of the Secrets Manager secret"
  value       = module.secrets_manager_secret.secret_id
}

output "secret_arn" {
  description = "The ARN of the Secrets Manager secret"
  value       = module.secrets_manager_secret.secret_arn
}

output "secret_name" {
  description = "The name of the Secrets Manager secret"
  value       = module.secrets_manager_secret.secret_name
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret"
  value       = module.secrets_manager_secret.secret_version_id
}

output "rotation_enabled" {
  description = "Whether automatic rotation is enabled for the secret"
  value       = module.secrets_manager_secret.rotation_enabled
}
