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

variable "name" {
  type        = string
  description = "Secret name"
}

variable "description" {
  type        = string
  description = "Secret description"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID or ARN"
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Recovery window in days"
  default     = 30
}

variable "force_overwrite_replica_secret" {
  type        = bool
  description = "Force overwrite replica secret"
  default     = false
  sensitive = true
}

variable "replica_regions" {
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  description = "Replica regions"
  default     = []
}

variable "secret_string" {
  type        = string
  description = "Secret string value"
  default     = null
  sensitive   = true
}

variable "secret_binary" {
  type        = string
  description = "Secret binary value"
  default     = null
  sensitive   = true
}

variable "version_stages" {
  type        = list(string)
  description = "Version stages"
  default     = null
}

variable "enable_rotation" {
  type        = bool
  description = "Enable rotation"
  default     = false
}

variable "rotation_lambda_arn" {
  type        = string
  description = "Rotation Lambda ARN"
  default     = null
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "Rotation interval in days"
  default     = 30
}

variable "block_public_policy" {
  type        = bool
  description = "Block public policy"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags for the secret"
  default     = {}
}
