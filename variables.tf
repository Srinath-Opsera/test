variable "service" {
  type        = string
  description = "Service name"
}

variable "team" {
  type        = string
  description = "Team name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "region" {
  type        = string
  description = "AWS region"
}

# S3 Bucket variables
variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for CloudTrail logs"
}

variable "s3_versioning_enabled" {
  type        = bool
  description = "Whether versioning is enabled on the S3 bucket"
  default     = true
}

variable "s3_sse_algorithm" {
  type        = string
  description = "Server-side encryption algorithm for S3 bucket"
  default     = "AES256"
}

variable "s3_kms_master_key_id" {
  type        = string
  description = "KMS master key ID for S3 bucket encryption"
  default     = null
}

variable "s3_force_destroy" {
  type        = bool
  description = "Whether to force destroy the S3 bucket"
  default     = false
}

variable "s3_bucket_policy_json" {
  type        = string
  description = "S3 bucket policy JSON"
  default     = null
}

variable "s3_block_public_acls" {
  type        = bool
  description = "Whether to block public ACLs on the S3 bucket"
  default     = true
}

variable "s3_block_public_policy" {
  type        = bool
  description = "Whether to block public policies on the S3 bucket"
  default     = true
}

variable "s3_ignore_public_acls" {
  type        = bool
  description = "Whether to ignore public ACLs on the S3 bucket"
  default     = true
}

variable "s3_restrict_public_buckets" {
  type        = bool
  description = "Whether to restrict public buckets"
  default     = true
}

variable "s3_lifecycle_rules" {
  type        = list(any)
  description = "S3 bucket lifecycle rules"
  default     = []
}

variable "s3_tags" {
  type        = map(string)
  description = "Additional tags for S3 bucket"
  default     = {}
}

# IAM Role variables
variable "iam_role_name" {
  type        = string
  description = "Name of the IAM role for CloudTrail"
}

variable "iam_role_description" {
  type        = string
  description = "Description of the IAM role"
  default     = ""
}

variable "iam_role_path" {
  type        = string
  description = "Path for the IAM role"
  default     = "/"
}

variable "iam_role_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "List of principals that can assume the IAM role"
}

variable "iam_role_max_session_duration" {
  type        = number
  description = "Maximum session duration for the IAM role"
  default     = 3600
}

variable "iam_role_managed_policy_arns" {
  type        = list(string)
  description = "List of managed policy ARNs to attach to the IAM role"
  default     = []
}

variable "iam_role_inline_policies" {
  type        = map(string)
  description = "Map of inline policies to attach to the IAM role"
  default     = {}
}

variable "iam_role_permissions_boundary" {
  type        = string
  description = "ARN of the permissions boundary for the IAM role"
  default     = null
}

variable "iam_role_force_detach_policies" {
  type        = bool
  description = "Whether to force detach policies from the IAM role"
  default     = false
}

variable "iam_role_tags" {
  type        = map(string)
  description = "Additional tags for IAM role"
  default     = {}
}

# CloudTrail variables
variable "cloudtrail_trail_name" {
  type        = string
  description = "Name of the CloudTrail"
}

variable "cloudtrail_s3_key_prefix" {
  type        = string
  description = "S3 key prefix for CloudTrail logs"
  default     = null
}

variable "cloudtrail_include_global_service_events" {
  type        = bool
  description = "Whether to include global service events"
  default     = true
}

variable "cloudtrail_is_multi_region_trail" {
  type        = bool
  description = "Whether the trail is created in all regions"
  default     = true
}

variable "cloudtrail_enable_logging" {
  type        = bool
  description = "Whether logging is enabled for the trail"
  default     = true
}

variable "cloudtrail_enable_log_file_validation" {
  type        = bool
  description = "Whether log file integrity validation is enabled"
  default     = true
}

variable "cloudtrail_is_organization_trail" {
  type        = bool
  description = "Whether the trail is an organization trail"
  default     = false
}

variable "cloudtrail_cloudwatch_logs_group_arn" {
  type        = string
  description = "ARN of the CloudWatch Logs log group"
  default     = null
}

variable "cloudtrail_cloudwatch_logs_role_arn" {
  type        = string
  description = "ARN of the IAM role for CloudWatch Logs delivery"
  default     = null
}

variable "cloudtrail_kms_key_id" {
  type        = string
  description = "KMS key ID for log encryption"
  default     = null
}

variable "cloudtrail_sns_topic_name" {
  type        = string
  description = "SNS topic name for notifications"
  default     = null
}

variable "cloudtrail_event_selectors" {
  type        = list(object({}))
  description = "CloudTrail event selectors"
  default     = []
}

variable "cloudtrail_insight_selectors" {
  type        = list(object({}))
  description = "CloudTrail insight selectors"
  default     = []
}

variable "cloudtrail_tags" {
  type        = map(string)
  description = "Additional tags for CloudTrail"
  default     = {}
}