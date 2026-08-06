module "secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                             = var.name
  description                      = var.description
  kms_key_id                       = var.kms_key_id
  recovery_window_in_days          = var.recovery_window_in_days
  force_overwrite_replica_secret   = var.force_overwrite_replica_secret
  replica_regions                  = var.replica_regions
  secret_string                    = var.secret_string
  secret_binary                    = var.secret_binary
  version_stages                   = var.version_stages
  enable_rotation                  = var.enable_rotation
  rotation_lambda_arn              = var.rotation_lambda_arn
  rotation_automatically_after_days = var.rotation_automatically_after_days
  block_public_policy              = var.block_public_policy

  tags = var.tags
}
