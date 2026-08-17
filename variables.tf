variable "region" {
  type        = string
  description = "AWS region"
}

variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name"
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion even if non-empty"
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 versioning"
  default     = true
}

variable "sse_algorithm" {
  type        = string
  description = "Server-side encryption algorithm"
  default     = "AES256"
}

variable "block_public_acls" {
  type        = bool
  description = "Block public ACLs on bucket and objects"
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Block public bucket policies"
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Ignore public ACLs"
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Restrict public bucket policies"
  default     = true
}

variable "s3_tags" {
  type        = map(string)
  description = "Tags for the S3 bucket"
  default     = {}
}

variable "service_name" {
  type        = string
  description = "Service name for resource tagging"
}

variable "sub_service_name" {
  type        = string
  description = "Variable referenced by provider default_tags"
}

variable "group" {
  type        = string
  description = "Group name for resource tagging"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. dev, staging, prod)"
}
