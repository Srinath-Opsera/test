variable "trail_name" {
  type        = string
  description = "Name of the CloudTrail"
  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+$", var.trail_name))
    error_message = "Trail name must contain only letters, numbers, periods, hyphens, and underscores."
  }
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket where CloudTrail logs will be delivered"
}

variable "s3_key_prefix" {
  type        = string
  description = "S3 key prefix for CloudTrail logs"
  default     = null
}

variable "include_global_service_events" {
  type        = bool
  description = "Whether to include global service events"
  default     = true
}

variable "is_multi_region_trail" {
  type        = bool
  description = "Whether the trail is created in all regions"
  default     = true
}

variable "enable_logging" {
  type        = bool
  description = "Whether logging is enabled for the trail"
  default     = true
}

variable "enable_log_file_validation" {
  type        = bool
  description = "Whether log file integrity validation is enabled"
  default     = true
}

variable "is_organization_trail" {
  type        = bool
  description = "Whether the trail is an organization trail"
  default     = false
}

variable "cloudwatch_logs_group_arn" {
  type        = string
  description = "ARN of the CloudWatch Logs log group"
  default     = null
}

variable "cloudwatch_logs_role_arn" {
  type        = string
  description = "ARN of the IAM role for CloudWatch Logs delivery"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID for log encryption"
  default     = null
}

variable "sns_topic_name" {
  type        = string
  description = "SNS topic name for notifications"
  default     = null
}

variable "event_selectors" {
  type = list(object({
    read_write_type                 = optional(string, "All")
    include_management_events       = optional(bool, true)
    exclude_management_event_sources = optional(list(string), [])
    data_resources = optional(list(object({
      type   = string
      values = list(string)
    })), [])
  }))
  description = "Event selectors for the trail"
  default     = []
}

variable "insight_selectors" {
  type = list(object({
    insight_type = string
  }))
  description = "Insight selectors for the trail"
  default     = []
  validation {
    condition = alltrue([
      for selector in var.insight_selectors :
      contains(["ApiCallRateInsight"], selector.insight_type)
    ])
    error_message = "Insight type must be ApiCallRateInsight."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource"
  default     = {}
}