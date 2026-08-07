output "repository_name" {
  description = "The name of the ECR repository."
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "The ARN of the ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "The URL of the ECR repository (used for docker push/pull)."
  value       = aws_ecr_repository.this.repository_url
}

output "repository_id" {
  description = "The registry ID where the repository was created."
  value       = aws_ecr_repository.this.registry_id
}

output "lifecycle_policy_id" {
  description = "The repository name that the lifecycle policy is applied to."
  value       = length(aws_ecr_lifecycle_policy.this) > 0 ? aws_ecr_lifecycle_policy.this[0].id : null
}

output "repository_policy_id" {
  description = "The repository name that the repository policy is applied to."
  value       = length(aws_ecr_repository_policy.this) > 0 ? aws_ecr_repository_policy.this[0].id : null
}
