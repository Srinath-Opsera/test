variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name."
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion even if non-empty (use with caution)."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 versioning."
  default     = true
}

variable "sse_algorithm" {
  type        = string
  description = "Server-side encryption: AES256 or aws:kms."
  default     = "AES256"
}

variable "kms_master_key_id" {
  type        = string
  description = "KMS key ID when sse_algorithm is aws:kms."
  default     = null
}

variable "block_public_acls" {
  type        = bool
  description = "Block public ACLs on bucket and objects."
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Block public bucket policies."
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Ignore public ACLs."
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Restrict public bucket policies."
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
  description = "Lifecycle configuration rules."
  default     = []
}

variable "bucket_policy_json" {
  type        = string
  description = "Optional JSON bucket policy document."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags for the S3 bucket."
  default     = {}
}
