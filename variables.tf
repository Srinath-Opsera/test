variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name prefix for ALB resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the ALB"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for the ALB"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS listener"
}

variable "internal" {
  type        = bool
  description = "Whether the load balancer is internal"
  default     = false
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on the ALB"
  default     = false
}

variable "idle_timeout" {
  type        = number
  description = "Idle timeout in seconds"
  default     = 60
}

variable "target_port" {
  type        = number
  description = "Port on targets for health checks and forwarding"
  default     = 80
}

variable "target_protocol" {
  type        = string
  description = "Protocol for target group"
  default     = "HTTP"
}

variable "health_check_path" {
  type        = string
  description = "Health check HTTP path"
  default     = "/"
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy for HTTPS listener"
  default     = "ELBSecurityPolicy-2016-08"
}

variable "additional_certificate_arns" {
  type        = list(string)
  description = "Additional ACM certificate ARNs for SNI"
  default     = []
}

variable "alb_tags" {
  type        = map(string)
  description = "Tags for ALB resources"
  default     = {}
}

variable "ecr_name" {
  type        = string
  description = "ECR repository name"
}

variable "image_tag_mutability" {
  type        = string
  description = "Tag mutability setting for the ECR repository"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Scan images on push"
  default     = true
}

variable "encryption_type" {
  type        = string
  description = "Encryption type for the ECR repository"
  default     = "AES256"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key ARN for ECR encryption"
  default     = null
}

variable "force_delete" {
  type        = bool
  description = "Delete ECR repository even if it contains images"
  default     = false
}

variable "lifecycle_policy" {
  type        = string
  description = "JSON-encoded ECR lifecycle policy"
  default     = null
}

variable "repository_policy" {
  type        = string
  description = "JSON-encoded ECR repository policy"
  default     = null
}

variable "replication_destinations" {
  type = list(object({
    region      = string
    registry_id = string
  }))
  description = "ECR replication destination configurations"
  default     = []
}

variable "replication_filters" {
  type = list(object({
    filter      = string
    filter_type = string
  }))
  description = "ECR replication filter configurations"
  default     = []
}

variable "ecr_tags" {
  type        = map(string)
  description = "Tags for ECR repository"
  default     = {}
}

variable "secret_name" {
  type        = string
  description = "Secrets Manager secret name"
}

variable "description" {
  type        = string
  description = "Secret description"
  default     = null
}

variable "secret_kms_key_id" {
  type        = string
  description = "KMS key ID for secret encryption"
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Recovery window in days before secret deletion"
  default     = 30
}

variable "force_overwrite_replica_secret" {
  type        = bool
  description = "Overwrite secret with same name in replica region"
  default     = false
  sensitive = true
}

variable "replica_regions" {
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  description = "Replica region configurations for the secret"
  default     = []
}

variable "secret_string" {
  type        = string
  description = "Secret value as string"
  default     = null
  sensitive   = true
}

variable "secret_binary" {
  type        = string
  description = "Secret value as binary (base64-encoded)"
  default     = null
  sensitive   = true
}

variable "version_stages" {
  type        = list(string)
  description = "Staging labels for the secret version"
  default     = null
}

variable "enable_rotation" {
  type        = bool
  description = "Enable automatic secret rotation"
  default     = false
}

variable "rotation_lambda_arn" {
  type        = string
  description = "Lambda ARN for secret rotation"
  default     = null
}

variable "rotation_automatically_after_days" {
  type        = number
  description = "Days between automatic secret rotations"
  default     = 30
}

variable "secret_policy" {
  type        = string
  description = "JSON resource policy for the secret"
  default     = null
}

variable "block_public_policy" {
  type        = bool
  description = "Block broad resource-based policies on the secret"
  default     = true
}

variable "secret_tags" {
  type        = map(string)
  description = "Tags for Secrets Manager secret"
  default     = {}
}
