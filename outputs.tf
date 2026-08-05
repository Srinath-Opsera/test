output "secret_id" {
  description = "The ID of the secret (same as the ARN)."
  value       = module.secrets_manager_secret.secret_id
}

output "secret_arn" {
  description = "The ARN of the secret."
  value       = module.secrets_manager_secret.secret_arn
}

output "secret_name" {
  description = "The name of the secret."
  value       = module.secrets_manager_secret.secret_name
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret."
  value       = module.secrets_manager_secret.secret_version_id
}

output "rotation_enabled" {
  description = "Whether automatic rotation is enabled for the secret."
  value       = module.secrets_manager_secret.rotation_enabled
}

output "kms_key_id" {
  description = "The KMS key ID used to encrypt the secret."
  value       = module.secrets_manager_secret.kms_key_id
}

output "replica_regions" {
  description = "The list of regions where the secret is replicated."
  value       = module.secrets_manager_secret.replica_regions
}
