region       = "us-east-1"
service_name = "test"
team         = "affinity"
environment  = "staging"

# ECR
name                     = "affinity-test-staging"
image_tag_mutability     = "MUTABLE"
scan_on_push             = true
encryption_type          = "AES256"
kms_key_arn              = null
force_delete             = false
lifecycle_policy         = null
repository_policy        = null
enable_registry_scanning = false
registry_scan_type       = "BASIC"
registry_scan_rules      = []
ecr_tags = {
  Name = "ecr-affinity-test-staging"
}

# S3
bucket_name             = "s3-tfstate-affinity-test-staging"
force_destroy           = false
versioning_enabled      = true
sse_algorithm           = "AES256"
kms_master_key_id       = null
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
lifecycle_rules         = []
bucket_policy_json      = null
s3_tags = {
  Name = "s3-tfstate-affinity-test-staging"
}

# Secrets Manager
secret_name                       = "affinity-test-staging"
description                       = "Database credentials and app secrets for affinity test staging"
kms_key_id                        = null
recovery_window_in_days           = 30
force_overwrite_replica_secret    = false
replica_regions                   = []
secret_string                     = null
secret_binary                     = null
version_stages                    = null
enable_rotation                   = false
rotation_lambda_arn               = null
rotation_automatically_after_days = 30
secret_policy                     = null
secrets_block_public_policy       = true
secrets_tags = {
  Name = "secret-affinity-test-staging"
}
