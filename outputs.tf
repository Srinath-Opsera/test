output "secret_id" {
  description = "Secret ID"
  value       = module.secrets_manager_secret.secret_id
}

output "secret_arn" {
  description = "Secret ARN"
  value       = module.secrets_manager_secret.secret_arn
}

output "secret_name" {
  description = "Secret name"
  value       = module.secrets_manager_secret.secret_name
}

output "secret_version_id" {
  description = "Secret version ID"
  value       = module.secrets_manager_secret.secret_version_id
}

output "rotation_enabled" {
  description = "Rotation enabled"
  value       = module.secrets_manager_secret.rotation_enabled
}

output "replica_arns" {
  description = "Replica ARNs"
  value       = module.secrets_manager_secret.replica_arns
}
