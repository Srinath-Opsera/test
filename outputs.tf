output "lb_id" {
  value = module.terraform_aws_alb.lb_id
}

output "lb_arn" {
  value = module.terraform_aws_alb.lb_arn
}

output "lb_dns_name" {
  value = module.terraform_aws_alb.lb_dns_name
}

output "lb_zone_id" {
  value = module.terraform_aws_alb.lb_zone_id
}

output "target_group_arn" {
  value = module.terraform_aws_alb.target_group_arn
}

output "https_listener_arn" {
  value = module.terraform_aws_alb.https_listener_arn
}

output "repository_name" {
  value = module.aws_ecr_repository.repository_name
}

output "repository_arn" {
  value = module.aws_ecr_repository.repository_arn
}

output "repository_url" {
  value = module.aws_ecr_repository.repository_url
}

output "registry_id" {
  value = module.aws_ecr_repository.registry_id
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
