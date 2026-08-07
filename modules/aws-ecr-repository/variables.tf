variable "name" {
  description = "The name of the ECR repository."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9._/-]{1,254}$", var.name))
    error_message = "Repository name must be between 2 and 255 characters, start with a letter or digit, and contain only lowercase letters, digits, hyphens, underscores, periods, and forward slashes."
  }
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE."
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either 'MUTABLE' or 'IMMUTABLE'."
  }
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository."
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS. Set to null to use the default AES256 encryption without an explicit block."
  type        = string
  default     = "AES256"

  validation {
    condition     = var.encryption_type == null || contains(["AES256", "KMS"], var.encryption_type)
    error_message = "encryption_type must be 'AES256', 'KMS', or null."
  }
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption. Required when encryption_type is KMS."
  type        = string
  default     = null
}

variable "force_delete" {
  description = "If true, the repository will be deleted even if it contains images."
  type        = bool
  default     = false
}

variable "lifecycle_policy" {
  description = "A JSON-encoded ECR lifecycle policy document. If null, no lifecycle policy is created."
  type        = string
  default     = null
}

variable "repository_policy" {
  description = "A JSON-encoded ECR repository policy document. If null, no repository policy is created."
  type        = string
  default     = null
}

variable "enable_registry_scanning" {
  description = "Whether to configure registry-level scanning settings."
  type        = bool
  default     = false
}

variable "registry_scan_type" {
  description = "The scanning type to set for the registry. Valid values are BASIC or ENHANCED."
  type        = string
  default     = "BASIC"

  validation {
    condition     = contains(["BASIC", "ENHANCED"], var.registry_scan_type)
    error_message = "registry_scan_type must be either 'BASIC' or 'ENHANCED'."
  }
}

variable "registry_scan_rules" {
  description = "A list of scanning rules to apply at the registry level. Each rule requires scan_frequency, filter, and filter_type."
  type = list(object({
    scan_frequency = string
    filter         = string
    filter_type    = string
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.registry_scan_rules :
      contains(["SCAN_ON_PUSH", "CONTINUOUS_SCAN", "MANUAL"], rule.scan_frequency)
    ])
    error_message = "Each registry scan rule's scan_frequency must be one of: SCAN_ON_PUSH, CONTINUOUS_SCAN, MANUAL."
  }

  validation {
    condition = alltrue([
      for rule in var.registry_scan_rules :
      contains(["WILDCARD"], rule.filter_type)
    ])
    error_message = "Each registry scan rule's filter_type must be 'WILDCARD'."
  }
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
