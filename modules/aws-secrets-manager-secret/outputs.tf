output "secret_id" {
  description = "The ID of the secret (same as the ARN)."
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "The ARN of the secret."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "The name of the secret."
  value       = aws_secretsmanager_secret.this.name
}

output "secret_version_id" {
  description = "The unique identifier of the version of the secret."
  value       = try(aws_secretsmanager_secret_version.this[0].version_id, null)
}

output "rotation_enabled" {
  description = "Whether automatic rotation is enabled for the secret."
  value       = aws_secretsmanager_secret.this.rotation_enabled
}

output "kms_key_id" {
  description = "The KMS key ID used to encrypt the secret, if any."
  value       = aws_secretsmanager_secret.this.kms_key_id
}
