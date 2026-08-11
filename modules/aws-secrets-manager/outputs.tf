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
  value       = length(aws_secretsmanager_secret_version.this) > 0 ? aws_secretsmanager_secret_version.this[0].version_id : null
}

output "rotation_enabled" {
  description = "Whether automatic rotation is enabled for the secret."
  value       = length(aws_secretsmanager_secret_rotation.this) > 0
}

output "replica_arns" {
  description = "A map of replica region to replica secret ARN."
  value = {
    for r in aws_secretsmanager_secret.this.replica :
    r.region => r.arn
  }
}
