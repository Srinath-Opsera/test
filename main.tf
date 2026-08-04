module "secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                              = var.name
  description                       = var.description
  recovery_window_in_days           = var.recovery_window_in_days
  force_overwrite_replica_secret    = var.force_overwrite_replica_secret
  secret_string                     = var.secret_string
  enable_rotation                   = var.enable_rotation
  rotation_automatically_after_days = var.rotation_automatically_after_days
  block_public_policy               = var.block_public_policy

  tags = {}
}
