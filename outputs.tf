output "repository_name" {
  value = module.aws_ecr_repository.repository_name
}

output "repository_arn" {
  value = module.aws_ecr_repository.repository_arn
}

output "repository_url" {
  value = module.aws_ecr_repository.repository_url
}

output "repository_id" {
  value = module.aws_ecr_repository.repository_id
}

output "bucket_id" {
  value = module.terraform_aws_s3.bucket_id
}

output "bucket_arn" {
  value = module.terraform_aws_s3.bucket_arn
}

output "bucket_domain_name" {
  value = module.terraform_aws_s3.bucket_domain_name
}

output "bucket_regional_domain_name" {
  value = module.terraform_aws_s3.bucket_regional_domain_name
}

output "secret_id" {
  value = module.aws_secrets_manager_secret.secret_id
}

output "secret_arn" {
  value = module.aws_secrets_manager_secret.secret_arn
}

output "secret_name" {
  value = module.aws_secrets_manager_secret.secret_name
}

output "secret_version_id" {
  value = module.aws_secrets_manager_secret.secret_version_id
}

output "rotation_enabled" {
  value = module.aws_secrets_manager_secret.rotation_enabled
}
