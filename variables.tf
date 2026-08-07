variable "region" {
  type        = string
  description = "AWS region"
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

variable "name" {
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
  description = "ECR scan on push"
  default     = true
}

variable "encryption_type" {
  type        = string
  description = "ECR encryption type"
  default     = "AES256"
}

variable "kms_key_arn" {
  type        = string
  description = "ECR KMS key ARN"
  default     = null
}

variable "force_delete" {
  type        = bool
  description = "ECR force delete"
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

variable "enable_registry_scanning" {
  type        = bool
  description = "ECR enable registry scanning"
  default     = false
}

variable "registry_scan_type" {
  type        = string
  description = "ECR registry scan type"
  default     = "BASIC"
}

variable "registry_scan_rules" {
  type = list(object({
    scan_frequency = string
    filter         = string
    filter_type    = string
  }))
  description = "ECR registry scan rules"
  default     = []
}

variable "ecr_tags" {
  type        = map(string)
  description = "ECR repository tags"
  default     = {}
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "force_destroy" {
  type        = bool
  description = "S3 force destroy"
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "S3 versioning enabled"
  default     = true
}

variable "sse_algorithm" {
  type        = string
  description = "S3 SSE algorithm"
  default     = "AES256"
}

variable "kms_master_key_id" {
  type        = string
  description = "S3 KMS master key ID"
  default     = null
}

variable "block_public_acls" {
  type        = bool
  description = "S3 block public ACLs"
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "S3 block public policy"
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "S3 ignore public ACLs"
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "S3 restrict public buckets"
  default     = true
}

variable "lifecycle_rules" {
  type = list(object({
    id                                 = string
    status                             = optional(string, "Enabled")
    prefix                             = optional(string, "")
    filter_tags                        = optional(map(string), {})
    expiration_days                    = optional(number)
    noncurrent_version_expiration_days = optional(number)
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
  }))
  description = "S3 lifecycle rules"
  default     = []
}

variable "bucket_policy_json" {
  type        = string
  description = "S3 bucket policy JSON"
  default     = null
}

variable "s3_tags" {
  type        = map(string)
  description = "S3 bucket tags"
  default     = {}
}

variable "secret_name" {
  type        = string
  description = "Secrets Manager secret name"
}

variable "description" {
  type        = string
  description = "Secrets Manager secret description"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "Secrets Manager KMS key ID"
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Secrets Manager recovery window in days"
  default     = 30
}

variable "force_overwrite_replica_secret" {
  type        = bool
  description = "Secrets Manager force overwrite replica secret"
  default     = false
  sensitive = true
}

variable "replica_regions" {
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  description = "Secrets Manager replica regions"
  default     = []
}

variable "secret_string" {
  type        = string
  description = "Secrets Manager secret string"
  default     = null
  sensitive   = true
}

variable "secret_binary" {
  type        = string
  description = "Secrets Manager secret binary"
  default     = null
  sensitive   = true
}

variable "version_stages" {
  type        = list(string)
  description = "Secrets Manager version stages"
  default     = null
}

variable "enable_rotation" {
  type        = bool
  description = "Secrets Manager enable rotation"
  default     = false
}

variable "rotation_lambda_arn" {
  type        = string
  description = "Secrets Manager rotation Lambda ARN"
  default     = null
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "Secrets Manager rotation interval in days"
  default     = 30
}

variable "secret_policy" {
  type        = string
  description = "Secrets Manager secret policy JSON"
  default     = null
}

variable "secrets_block_public_policy" {
  type        = bool
  description = "Secrets Manager block public policy"
  default     = true
}

variable "secrets_tags" {
  type        = map(string)
  description = "Secrets Manager secret tags"
  default     = {}
}
