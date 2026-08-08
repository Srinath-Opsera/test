module "terraform_aws_alb" {
  source = "./modules/terraform-aws-alb"

  name                      = var.name
  vpc_id                    = var.vpc_id
  subnet_ids                = var.subnet_ids
  security_group_ids        = var.security_group_ids
  certificate_arn           = var.certificate_arn
  internal                  = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout              = var.idle_timeout
  target_port               = var.target_port
  target_protocol           = var.target_protocol
  health_check_path         = var.health_check_path
  ssl_policy                = var.ssl_policy
  additional_certificate_arns = var.additional_certificate_arns
  tags                      = var.alb_tags
}

module "aws_ecr_repository" {
  source = "./modules/aws-ecr-repository"

  name                   = var.ecr_name
  image_tag_mutability   = var.image_tag_mutability
  scan_on_push           = var.scan_on_push
  encryption_type        = var.encryption_type
  kms_key_arn            = var.kms_key_arn
  force_delete           = var.force_delete
  lifecycle_policy       = var.lifecycle_policy
  repository_policy      = var.repository_policy
  replication_destinations = var.replication_destinations
  replication_filters    = var.replication_filters
  tags                   = var.ecr_tags
}

module "aws_secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                            = var.secret_name
  description                     = var.description
  kms_key_id                      = var.secret_kms_key_id
  recovery_window_in_days         = var.recovery_window_in_days
  force_overwrite_replica_secret  = var.force_overwrite_replica_secret
  replica_regions                 = var.replica_regions
  secret_string                   = var.secret_string
  secret_binary                   = var.secret_binary
  version_stages                  = var.version_stages
  enable_rotation                 = var.enable_rotation
  rotation_lambda_arn             = var.rotation_lambda_arn
  rotation_automatically_after_days = var.rotation_automatically_after_days
  secret_policy                   = var.secret_policy
  block_public_policy             = var.block_public_policy
  tags                            = var.secret_tags
}
