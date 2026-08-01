variable "name" {
  description = "The name of the secret. If omitted, Terraform will assign a random, unique name."
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 512
    error_message = "The secret name must be between 1 and 512 characters."
  }
}

variable "description" {
  description = "A description of the secret."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "The ARN or ID of the AWS KMS key to use to encrypt the secret. If not specified, the default AWS managed key is used."
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "The number of days that AWS Secrets Manager waits before it can delete the secret. Set to 0 to force immediate deletion with no recovery window."
  type        = number
  default     = 30

  validation {
    condition     = var.recovery_window_in_days == 0 || (var.recovery_window_in_days >= 7 && var.recovery_window_in_days <= 30)
    error_message = "The recovery_window_in_days must be 0 (force delete) or between 7 and 30 days."
  }
}

variable "force_overwrite_replica_secret" {
  description = "Whether to overwrite a secret with the same name in the destination region during replication."
  type        = bool
  default     = false
}

variable "replica_regions" {
  description = "List of replica region configurations. Each object must include a 'region' key and optionally a 'kms_key_id' key."
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  default = []
}

variable "secret_string" {
  description = "The secret value to store as a plaintext string. Conflicts with secret_binary. Use a JSON-encoded string for structured secrets."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_binary" {
  description = "The secret value to store as binary data, base64-encoded. Conflicts with secret_string."
  type        = string
  default     = null
  sensitive   = true
}

variable "version_stages" {
  description = "List of staging labels attached to this version of the secret. If not specified, AWS assigns the AWSCURRENT label."
  type        = list(string)
  default     = null
}

variable "enable_rotation" {
  description = "Whether to enable automatic rotation for the secret."
  type        = bool
  default     = false
}

variable "rotation_lambda_arn" {
  description = "The ARN of the Lambda function that can rotate the secret. Required when enable_rotation is true."
  type        = string
  default     = null

  validation {
    condition     = !var.enable_rotation || (var.enable_rotation && var.rotation_lambda_arn != null)
    error_message = "rotation_lambda_arn must be provided when enable_rotation is true."
  }
}

variable "rotation_automatically_after_days" {
  description = "The number of days between automatic scheduled rotations of the secret."
  type        = number
  default     = 30

  validation {
    condition     = var.rotation_automatically_after_days >= 1 && var.rotation_automatically_after_days <= 365
    error_message = "rotation_automatically_after_days must be between 1 and 365."
  }
}

variable "secret_policy" {
  description = "A valid JSON document representing a resource policy. If null, no policy is attached."
  type        = string
  default     = null
}

variable "block_public_policy" {
  description = "Whether to block resource-based policies that allow broad access to the secret."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the secret."
  type        = map(string)
  default     = {}
}
