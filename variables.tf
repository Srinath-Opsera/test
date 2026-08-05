variable "region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. dev, staging, prod)"
}

variable "name" {
  type        = string
  description = "The name of the secret."
}

variable "description" {
  type        = string
  description = "A description of the secret."
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "The number of days that AWS Secrets Manager waits before it can delete the secret."
  default     = 30
}

variable "force_overwrite_replica_secret" {
  type        = bool
  description = "Whether to overwrite a secret with the same name in the destination region during replication."
  default     = false
}

variable "secret_string" {
  type        = string
  description = "The secret value to store as a plaintext string."
  default     = null
  sensitive   = true
}

variable "enable_rotation" {
  type        = bool
  description = "Whether to enable automatic secret rotation via a Lambda function."
  default     = false
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "The number of days between automatic scheduled rotations of the secret."
  default     = 30
}

variable "block_public_policy" {
  type        = bool
  description = "Whether to block resource-based policies that allow broad access to the secret."
  default     = true
}
