variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

variable "service_name" {
  type        = string
  description = "Service name"
}

variable "team" {
  type        = string
  description = "Team name"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "assume_role_arn_acct_792373136340" {
  type        = string
  description = "Role ARN for account 792373136340"
}

variable "assume_role_external_id_acct_792373136340" {
  type        = string
  description = "External ID for account 792373136340"
  default     = ""
}

variable "log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "CloudWatch log groups"
  default     = {}
}

variable "cloudwatch_tags" {
  type        = map(string)
  description = "Tags for CloudWatch resources"
  default     = {}
}

variable "name" {
  type        = string
  description = "IAM role name"
}

variable "assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Trust policy principals"
}

variable "description" {
  type        = string
  description = "IAM role description"
  default     = ""
}

variable "path" {
  type        = string
  description = "IAM role path"
  default     = "/"
}

variable "max_session_duration" {
  type        = number
  description = "Max session duration in seconds"
  default     = 3600
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "Managed policy ARNs to attach"
  default     = []
}

variable "force_detach_policies" {
  type        = bool
  description = "Force detach policies on destroy"
  default     = false
}

variable "iam_role_tags" {
  type        = map(string)
  description = "Tags for IAM role"
  default     = {}
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "security_group_description" {
  type        = string
  description = "Security group description"
  default     = "Managed by Terraform"
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
  description = "Inbound rules"
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
  description = "Outbound rules"
  default     = []
}

variable "default_egress_allow_all" {
  type        = bool
  description = "Default allow-all egress rule"
  default     = true
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
  default     = false
}

variable "security_group_tags" {
  type        = map(string)
  description = "Tags for security group"
  default     = {}
}

variable "repository_name" {
  type        = string
  description = "ECR repository name"
}

variable "image_tag_mutability" {
  type        = string
  description = "ECR image tag mutability"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Scan images on push"
  default     = true
}

variable "encryption_type" {
  type        = string
  description = "ECR encryption type"
  default     = "AES256"
}

variable "ecr_kms_key_arn" {
  type        = string
  description = "KMS key ARN for ECR"
  default     = null
}

variable "force_delete" {
  type        = bool
  description = "Force delete ECR repository"
  default     = false
}

variable "lifecycle_policy" {
  type        = string
  description = "ECR lifecycle policy JSON"
  default     = null
}

variable "repository_policy" {
  type        = string
  description = "ECR repository policy JSON"
  default     = null
}

variable "replication_destinations" {
  type = list(object({
    region      = string
    registry_id = string
  }))
  description = "ECR replication destinations"
  default     = []
}

variable "replication_filters" {
  type = list(object({
    filter      = string
    filter_type = string
  }))
  description = "ECR replication filters"
  default     = []
}

variable "ecr_tags" {
  type        = map(string)
  description = "Tags for ECR repository"
  default     = {}
}

variable "function_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_description" {
  type        = string
  description = "Lambda function description"
  default     = ""
}

variable "runtime" {
  type        = string
  description = "Lambda runtime"
  default     = null
}

variable "handler" {
  type        = string
  description = "Lambda handler"
  default     = null
}

variable "architecture" {
  type        = string
  description = "Lambda architecture"
  default     = "x86_64"
}

variable "image_uri" {
  type        = string
  description = "Lambda container image URI"
  # Placeholder — replaced by CI/CD pipeline after first image push
  default     = null
}

variable "timeout" {
  type        = number
  description = "Lambda timeout in seconds"
  default     = 30
}

variable "memory_size" {
  type        = number
  description = "Lambda memory size in MB"
  default     = 128
}

variable "publish" {
  type        = bool
  description = "Publish Lambda version"
  default     = false
}

variable "environment_variables" {
  type        = map(string)
  description = "Lambda environment variables"
  default     = {}
}

variable "layer_arns" {
  type        = list(string)
  description = "Lambda layer ARNs"
  default     = []
}

variable "create_iam_role" {
  type        = bool
  description = "Create Lambda IAM role"
  default     = false
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "Lambda VPC subnet IDs"
  default     = null
}

variable "log_retention_in_days" {
  type        = number
  description = "CloudWatch log retention in days"
  default     = 30
}

variable "lambda_tags" {
  type        = map(string)
  description = "Tags for Lambda function"
  default     = {}
}

variable "secret_name" {
  type        = string
  description = "Secrets Manager secret name"
}

variable "recovery_window_in_days" {
  type        = number
  description = "Secret recovery window in days"
  default     = 30
}

variable "force_overwrite_replica_secret" {
  type        = bool
  description = "Force overwrite replica secret"
  default     = false
  sensitive = true
}

variable "secret_key_value_pairs" {
  type        = map(string)
  description = "Secret key-value pairs"
  sensitive   = true
  default     = {}
}

variable "enable_rotation" {
  type        = bool
  description = "Enable secret rotation"
  default     = false
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "Days between secret rotations"
  default     = 30
}

variable "block_public_policy" {
  type        = bool
  description = "Block public secret policy"
  default     = true
}

variable "secrets_tags" {
  type        = map(string)
  description = "Tags for Secrets Manager secret"
  default     = {}
}

variable "cross_account_s3_bucket_name" {
  type        = string
  description = "Cross-account S3 bucket name"
  default     = "test-crossaccount-opsera-demo"
}


# --- Variables for resource policy injection ---

variable "existing_s3_bucket_cross_account_bucket_name" {
  description = "Name of the existing S3 bucket for policy attachment"
  type        = string
  default     = "test-crossaccount-opsera-demo"
}
