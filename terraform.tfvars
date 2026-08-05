region      = "us-east-1"
environment = "dev"

name                              = "platform-variable-format-dev"
description                       = "Application secrets for variable-format service"
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
