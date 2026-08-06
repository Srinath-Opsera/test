output "secret_id" {
  description = "ID of the secret"
  value       = module.secrets_manager_secret.secret_id
}

output "secret_arn" {
  description = "ARN of the secret"
  value       = module.secrets_manager_secret.secret_arn
}

output "secret_name" {
  description = "Name of the secret"
  value       = module.secrets_manager_secret.secret_name
}

output "secret_version_id" {
  description = "Version ID of the secret"
  value       = module.secrets_manager_secret.secret_version_id
}

output "rotation_enabled" {
  description = "Whether rotation is enabled for the secret"
  value       = module.secrets_manager_secret.rotation_enabled
}

output "kms_key_id" {
  description = "KMS key ID used to encrypt the secret"
  value       = module.secrets_manager_secret.kms_key_id
}
