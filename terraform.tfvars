region      = "us-east-1"
environment = "dev"
team        = "platform"

iam_policy_name = "belc-platform-variable-format-secrets-policy-dev"

secret_name                       = "variable-format-dev"
secret_description                = "Application secrets for variable-format service"
kms_key_id                        = null
recovery_window_in_days           = 7
force_overwrite_replica_secret    = false
secret_string = ""
enable_rotation                   = false
rotation_automatically_after_days = 30
block_public_policy               = true

default_tags = {
  grupo = "platform"
  service = "variable-format"
  environment = "dev"
  managed_by = "cloudforge"
}
