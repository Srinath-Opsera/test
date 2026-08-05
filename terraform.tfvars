region = "us-east-1"

name                             = "variable-format-dev"
description                      = "Secret containing API_TOKEN, DB_PASSWORD, and REDIS_URL"
kms_key_id                       = null
recovery_window_in_days          = 30
force_overwrite_replica_secret   = false
replica_regions                  = []
secret_string = ""
secret_binary                    = null
version_stages                   = null
enable_rotation                  = false
rotation_lambda_arn              = null
rotation_automatically_after_days = 30
block_public_policy              = true

tags = {
  Name = "variable-format-dev"
}

default_tags = {
  team = "hello"
  service = "variable-format"
  environment = "dev"
  managed_by = "cloudforge"
}
