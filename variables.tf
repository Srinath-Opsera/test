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

variable "iam_policy_name" {
  type        = string
  description = "Name of the IAM policy for Secrets Manager access"
}

variable "iam_policy_tags" {
  type        = map(string)
  description = "Tags for the IAM policy resource"
  default     = {}
}

variable "secret_name" {
  type        = string
  description = "The name of the Secrets Manager secret"
}

variable "secret_description" {
  type        = string
  description = "A description of the secret"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "The ARN or ID of the AWS KMS key to encrypt the secret"
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Number of days before the secret can be deleted"
  default     = 7
}

variable "force_overwrite_replica_secret" {
  type        = bool
  description = "Whether to overwrite a secret with the same name in the destination Region when replicating"
  default     = false
}

variable "secret_string" {
  type        = string
  description = "The text data to store in the secret as a JSON string"
  sensitive   = true
  default     = null
}

variable "enable_rotation" {
  type        = bool
  description = "Whether to enable automatic rotation for the secret"
  default     = false
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "Number of days between automatic scheduled rotations"
  default     = 30
}

variable "block_public_policy" {
  type        = bool
  description = "Whether to block resource-based policies that allow broad access"
  default     = true
}

variable "secret_tags" {
  type        = map(string)
  description = "Tags for the Secrets Manager secret"
  default     = {}
}
