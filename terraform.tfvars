service     = "my-app"
team        = "platform"
environment = "dev"
region      = "us-east-1"

# S3 Bucket configuration
s3_bucket_name           = "s3-0260504-idp"
s3_versioning_enabled    = true
s3_sse_algorithm        = "AES256"
s3_kms_master_key_id    = null
s3_force_destroy        = false
s3_bucket_policy_json   = null
s3_block_public_acls    = true
s3_block_public_policy  = true
s3_ignore_public_acls   = true
s3_restrict_public_buckets = true
s3_lifecycle_rules      = []
s3_tags                 = {}

# IAM Role configuration
iam_role_name = "s3"
iam_role_description = ""
iam_role_path = "/"
iam_role_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ec2.amazonaws.com"]
  }
]
iam_role_max_session_duration = 3600
iam_role_managed_policy_arns = []
iam_role_inline_policies = {}
iam_role_permissions_boundary = null
iam_role_force_detach_policies = false
iam_role_tags = {}

# CloudTrail configuration
cloudtrail_trail_name = "s3"
cloudtrail_s3_key_prefix = null
cloudtrail_include_global_service_events = true
cloudtrail_is_multi_region_trail = true
cloudtrail_enable_logging = true
cloudtrail_enable_log_file_validation = true
cloudtrail_is_organization_trail = false
cloudtrail_cloudwatch_logs_group_arn = null
cloudtrail_cloudwatch_logs_role_arn = null
cloudtrail_kms_key_id = null
cloudtrail_sns_topic_name = null
cloudtrail_event_selectors = []
cloudtrail_insight_selectors = []
cloudtrail_tags = {}