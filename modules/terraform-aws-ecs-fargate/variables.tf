variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster."
}

variable "service_name" {
  type        = string
  description = "Name of the ECS service."
}

variable "task_family" {
  type        = string
  description = "Family name for the task definition."
}

variable "cpu" {
  type        = number
  description = "Fargate task CPU units (256, 512, 1024, ...)."
  default     = 512
}

variable "memory" {
  type        = number
  description = "Fargate task memory in MB (must match CPU)."
  default     = 1024
}

variable "container_name" {
  type        = string
  description = "Primary container name in the task."
}

variable "container_image" {
  type        = string
  description = "Container image URI (ECR or Docker Hub)."
}

variable "container_port" {
  type        = number
  description = "Port exposed by the container."
  default     = 8080
}

variable "desired_count" {
  type        = number
  description = "Desired number of tasks."
  default     = 2
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for ECS tasks."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups for ECS tasks."
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign public IP in public subnets."
  default     = false
}

variable "target_group_arn" {
  type        = string
  description = "ALB target group ARN for load balanced service (optional)."
  default     = null
}

variable "enable_autoscaling" {
  type        = bool
  description = "Enable target tracking autoscaling on the service."
  default     = true
}

variable "autoscaling_min" {
  type        = number
  description = "Minimum task count when autoscaling is enabled."
  default     = 2
}

variable "autoscaling_max" {
  type        = number
  description = "Maximum task count when autoscaling is enabled."
  default     = 10
}

variable "autoscaling_cpu_target" {
  type        = number
  description = "Target average CPU percent for autoscaling."
  default     = 70
}

variable "log_retention_days" {
  type        = number
  description = "CloudWatch log retention in days."
  default     = 30
}

variable "execution_role_arn" {
  type        = string
  description = "IAM role ARN for ECS task execution (pull image, logs)."
}

variable "task_role_arn" {
  type        = string
  description = "IAM role ARN assumed by the application in the task."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags for ECS resources."
  default     = {}
}
