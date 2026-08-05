region = "us-east-1"

iam_policy_name = "belc-platty-variable-format-secrets-policy-auto"

iam_policy_tags = {
  service = "variable-format"
grupo   = "platty"
}

secret_name        = "variable-format-auto"
secret_description = "Application secrets for variable-format service"
kms_key_id         = null

recovery_window_in_days        = 7
force_overwrite_replica_secret = false

secret_string = ""

enable_rotation                   = false
rotation_automatically_after_days = 30
block_public_policy               = true

secret_tags = {
  service = "variable-format"
  env     = "auto"
  grupo   = "platty"
}

default_tags = {
  team = "platty"
  service = "variable-format"
  environment = "auto"
  managed_by = "cloudforge"
}
