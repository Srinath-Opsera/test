variable "region" {
  type        = string
  description = "AWS region to deploy resources into."
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# ── IAM Role ──────────────────────────────────────────────────────────────────
variable "iam_role_name" {
  type        = string
  description = "Name of the Lambda execution IAM role."
}

variable "iam_role_description" {
  type        = string
  description = "Description of the Lambda execution IAM role."
  default     = "IAM execution role for Lambda function affinity-test"
}

variable "assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Trust policy principals for the IAM role."
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of managed policy ARNs to attach to the IAM role."
  default     = []
}

# ── Secrets Manager ───────────────────────────────────────────────────────────
variable "secret_name" {
  type        = string
  description = "Name of the Secrets Manager secret."
}

variable "secret_description" {
  type        = string
  description = "Description of the Secrets Manager secret."
  default     = "Secrets for Lambda function affinity-test including API token and database passwords"
}

variable "recovery_window_in_days" {
  type        = number
  description = "Number of days before the secret can be permanently deleted (0 or 7-30)."
  default     = 7
}

variable "secret_string" {
  type        = string
  description = "JSON-encoded secret value containing AFFINITY_API_TOKEN, PGPASSWORD_QAS, PGPASSWORD_DEV."
  sensitive   = true
  default     = null
}
