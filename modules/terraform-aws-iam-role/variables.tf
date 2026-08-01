variable "name" {
  type        = string
  description = "Name of the IAM role."
}

variable "description" {
  type        = string
  description = "Description of the IAM role."
  default     = ""
}

variable "path" {
  type        = string
  description = "IAM path for the role."
  default     = "/"
}

variable "max_session_duration" {
  type        = number
  description = "Max session duration in seconds (3600-43200)."
  default     = 3600
}

variable "assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Trust policy: principal types and identifiers (Service, Federated, AWS)."
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "AWS or customer managed policy ARNs to attach."
  default     = []
}

variable "inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "Map of inline policy name to JSON policy documents."
  default     = {}
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of permissions boundary policy (optional)."
  default     = null
}

variable "force_detach_policies" {
  type        = bool
  description = "Force detach policies on destroy."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags for the IAM role."
  default     = {}
}
