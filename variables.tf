variable "region" {
  type        = string
  description = "AWS region for resource deployment"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

variable "aws_account_id" {
  type        = string
  description = "Primary AWS account ID (472496548172)"
}

# ─── Cross-account provider variables ────────────────────────────────────────
variable "assume_role_arn_acct_792373136340" {
  type        = string
  description = "IAM role ARN to assume in account 792373136340"
}

variable "assume_role_external_id_acct_792373136340" {
  type        = string
  description = "Optional external ID for assuming role in account 792373136340"
  default     = ""
}

# ─── CloudWatch Log Group ─────────────────────────────────────────────────────
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

# ─── IAM Role ─────────────────────────────────────────────────────────────────
variable "iam_role_name" {
  type        = string
  description = "Name of the Lambda execution IAM role"
}

variable "iam_role_description" {
  type        = string
  description = "Description of the Lambda execution IAM role"
  default     = ""
}

variable "iam_role_path" {
  type        = string
  description = "IAM path for the role"
  default     = "/"
}

variable "iam_role_max_session_duration" {
  type        = number
  description = "Max session duration in seconds"
  default     = 3600
}

variable "iam_role_force_detach_policies" {
  type        = bool
  description = "Force detach policies on destroy"
  default     = false
}

variable "assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Trust policy principal types and identifiers"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "Managed policy ARNs to attach to the IAM role"
  default     = []
}

# ─── Security Group ───────────────────────────────────────────────────────────
variable "security_group_name" {
  type        = string
  description = "Name of the Lambda security group"
}

variable "security_group_description" {
  type        = string
  description = "Description of the Lambda security group"
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the Lambda security group will be created"
}

variable "ingress_rules" {
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
  description = "Inbound rules for the security group"
  default     = []
}

variable "egress_rules" {
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
  description = "Outbound rules for the security group"
  default     = []
}

variable "default_egress_allow_all" {
  type        = bool
  description = "If true and egress_rules is empty, add a default allow-all egress rule"
  default     = true
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "Instruct Terraform to revoke all rules on delete"
  default     = false
}

# ─── Permission Bridge Variables ──────────────────────────────────────────────
variable "s3_bucket_name_test_crossaccount_opsera_demo" {
  type        = string
  description = "Name of the existing cross-account S3 bucket in account 792373136340"
}

variable "secrets_manager_secret_name" {
  type        = string
  description = "Name of the existing Secrets Manager secret in account 472496548172"
}


# --- Variables for resource policy injection ---

variable "existing_s3_bucket_cross_account_bucket_name" {
  description = "Name of the existing S3 bucket for policy attachment"
  type        = string
  default     = "test-crossaccount-opsera-demo"
}

variable "secrets_manager_secret_id" {
  description = "ID/ARN of the existing secretsmanager resource for policy attachment"
  type        = string
  default     = "affinity-test-secrets"
}
