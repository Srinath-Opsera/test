# S3 Bucket for CloudTrail logs
module "s3_bucket" {
  source = "./modules/s3"

  bucket_name           = var.s3_bucket_name
  versioning_enabled    = var.s3_versioning_enabled
  sse_algorithm        = var.s3_sse_algorithm
  kms_master_key_id    = var.s3_kms_master_key_id
  force_destroy        = var.s3_force_destroy
  bucket_policy_json   = var.s3_bucket_policy_json
  block_public_acls    = var.s3_block_public_acls
  block_public_policy  = var.s3_block_public_policy
  ignore_public_acls   = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
  lifecycle_rules      = var.s3_lifecycle_rules
  tags                 = merge(local.common_tags, var.s3_tags)
}

# IAM Role for CloudTrail
module "iam_role" {
  source = "./modules/iam-role"

  name                     = var.iam_role_name
  description             = var.iam_role_description
  path                    = var.iam_role_path
  assume_role_principals  = var.iam_role_assume_role_principals
  max_session_duration    = var.iam_role_max_session_duration
  managed_policy_arns     = var.iam_role_managed_policy_arns
  inline_policies         = var.iam_role_inline_policies
  permissions_boundary    = var.iam_role_permissions_boundary
  force_detach_policies   = var.iam_role_force_detach_policies
  tags                    = merge(local.common_tags, var.iam_role_tags)
}

# CloudTrail
module "cloudtrail" {
  source = "./modules/aws-cloudtrail"

  trail_name                      = var.cloudtrail_trail_name
  s3_bucket_name                 = module.s3_bucket.bucket_name
  s3_key_prefix                  = var.cloudtrail_s3_key_prefix
  include_global_service_events  = var.cloudtrail_include_global_service_events
  is_multi_region_trail          = var.cloudtrail_is_multi_region_trail
  enable_logging                 = var.cloudtrail_enable_logging
  enable_log_file_validation     = var.cloudtrail_enable_log_file_validation
  is_organization_trail          = var.cloudtrail_is_organization_trail
  cloudwatch_logs_group_arn      = var.cloudtrail_cloudwatch_logs_group_arn
  cloudwatch_logs_role_arn       = var.cloudtrail_cloudwatch_logs_role_arn
  kms_key_id                     = var.cloudtrail_kms_key_id
  sns_topic_name                 = var.cloudtrail_sns_topic_name
  event_selectors                = var.cloudtrail_event_selectors
  insight_selectors              = var.cloudtrail_insight_selectors
  tags                           = merge(local.common_tags, var.cloudtrail_tags)
}

# Common tags for all resources
locals {
  common_tags = {
    Service     = var.service
    Team        = var.team
    Environment = var.environment
    Region      = var.region
  }
}