# ============================================================
# General
# ============================================================
variable "region" {
  type        = string
  description = "AWS region for all resources"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. dev, staging, prod)"
  default     = "dev"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# ============================================================
# CloudWatch
# ============================================================
variable "log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "Map of CloudWatch log groups to create"
  default     = {}
}

variable "cloudwatch_tags" {
  type        = map(string)
  description = "Additional tags for the CloudWatch module (keys not already in default_tags)"
  default     = {}
}

# ============================================================
# Lambda Execution IAM Role
# ============================================================
variable "lambda_role_name" {
  type        = string
  description = "Name of the Lambda execution IAM role"
}

variable "lambda_role_description" {
  type        = string
  description = "Description of the Lambda execution IAM role"
  default     = ""
}

variable "lambda_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Trust policy principals for the Lambda execution role"
}

variable "lambda_managed_policy_arns" {
  type        = list(string)
  description = "Managed policy ARNs to attach to the Lambda execution role"
  default     = []
}

variable "lambda_force_detach_policies" {
  type        = bool
  description = "Force detach policies on destroy"
  default     = false
}

variable "lambda_max_session_duration" {
  type        = number
  description = "Max session duration in seconds for the Lambda execution role"
  default     = 3600
}

variable "lambda_role_tags" {
  type        = map(string)
  description = "Additional tags for the Lambda execution IAM role (keys not already in default_tags)"
  default     = {}
}

# ============================================================
# Lambda Security Group
# ============================================================
variable "lambda_sg_name" {
  type        = string
  description = "Name of the Lambda security group"
}

variable "lambda_sg_description" {
  type        = string
  description = "Description of the Lambda security group"
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the Lambda security group will be created"
}

variable "lambda_sg_egress_rules" {
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Egress rules for the Lambda security group"
  default     = []
}

variable "lambda_sg_tags" {
  type        = map(string)
  description = "Additional tags for the Lambda security group (keys not already in default_tags)"
  default     = {}
}

# ============================================================
# Cross-account S3 bucket (existing resource — permission bridge)
# ============================================================
variable "crossaccount_s3_bucket_name" {
  type        = string
  description = "Name of the existing cross-account S3 bucket in account 792373136340"
  default     = "test-crossaccount-opsera-demo"
}

# ============================================================
# Additional account provider variables
# ============================================================
variable "assume_role_arn_acct_792373136340" {
  type        = string
  description = "IAM role ARN to assume in account 792373136340 for cross-account provider"
}

variable "assume_role_external_id_acct_792373136340" {
  type        = string
  description = "Optional external ID for assuming the role in account 792373136340"
  default     = ""
}


# --- Variables for resource policy injection ---

variable "existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name" {
  description = "Name of the existing S3 bucket for policy attachment"
  type        = string
  default     = "test-crossaccount-opsera-demo"
}
