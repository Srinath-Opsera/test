module "aws_ecr_repository" {
  source = "./modules/aws-ecr-repository"

  name                   = var.name
  image_tag_mutability   = var.image_tag_mutability
  scan_on_push           = var.scan_on_push
  encryption_type        = var.encryption_type
  kms_key_arn            = var.kms_key_arn
  force_delete           = var.force_delete
  lifecycle_policy       = var.lifecycle_policy
  repository_policy      = var.repository_policy
  enable_registry_scanning = var.enable_registry_scanning
  registry_scan_type     = var.registry_scan_type
  registry_scan_rules    = var.registry_scan_rules
  tags                   = var.ecr_tags
}

module "terraform_aws_s3" {
  source = "./modules/terraform-aws-s3"

  bucket_name              = var.bucket_name
  force_destroy            = var.force_destroy
  versioning_enabled       = var.versioning_enabled
  sse_algorithm            = var.sse_algorithm
  kms_master_key_id        = var.kms_master_key_id
  block_public_acls        = var.block_public_acls
  block_public_policy      = var.block_public_policy
  ignore_public_acls       = var.ignore_public_acls
  restrict_public_buckets  = var.restrict_public_buckets
  lifecycle_rules          = var.lifecycle_rules
  bucket_policy_json       = var.bucket_policy_json
  tags                     = var.s3_tags
}

module "aws_secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                              = var.secret_name
  description                       = var.description
  kms_key_id                        = var.kms_key_id
  recovery_window_in_days           = var.recovery_window_in_days
  force_overwrite_replica_secret    = var.force_overwrite_replica_secret
  replica_regions                   = var.replica_regions
  secret_string                     = var.secret_string
  secret_binary                     = var.secret_binary
  version_stages                    = var.version_stages
  enable_rotation                   = var.enable_rotation
  rotation_lambda_arn               = var.rotation_lambda_arn
  rotation_automatically_after_days = var.rotation_automatically_after_days
  secret_policy                     = var.secret_policy
  block_public_policy               = var.secrets_block_public_policy
  tags                              = var.secrets_tags
}
