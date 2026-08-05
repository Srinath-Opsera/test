variable "name" {
  type        = string
  description = "Name prefix for ALB resources."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for load balancer and target group."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the ALB (typically two+ public subnets)."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups attached to the ALB."
}

variable "internal" {
  type        = bool
  description = "Whether the load balancer is internal."
  default     = false
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on the ALB."
  default     = false
}

variable "idle_timeout" {
  type        = number
  description = "Idle timeout in seconds."
  default     = 60
}

variable "target_port" {
  type        = number
  description = "Port on targets for health checks and forwarding."
  default     = 80
}

variable "target_protocol" {
  type        = string
  description = "Protocol for target group (HTTP or HTTPS)."
  default     = "HTTP"
}

variable "health_check_path" {
  type        = string
  description = "Health check HTTP path."
  default     = "/"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS listener (required for HTTPS)."
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy for HTTPS listener."
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "additional_certificate_arns" {
  type        = list(string)
  description = "Additional ACM certificate ARNs for SNI."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags for ALB resources."
  default     = {}
}
