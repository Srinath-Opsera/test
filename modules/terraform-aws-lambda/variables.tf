variable "function_name" {
  type        = string
  description = "Name of the Lambda function."
}

variable "description" {
  type        = string
  description = "Description of the function."
  default     = ""
}

variable "runtime" {
  type        = string
  description = "Lambda runtime identifier (e.g. python3.12, nodejs20.x)."
}

variable "handler" {
  type        = string
  description = "Function entrypoint (e.g. index.handler)."
}

variable "filename" {
  type        = string
  description = "Path to deployment package zip file."
  default     = null
}

variable "source_code_hash" {
  type        = string
  description = "Hash to trigger redeployments when zip changes."
  default     = null
}

variable "memory_size" {
  type        = number
  description = "Memory in MB."
  default     = 128
}

variable "timeout" {
  type        = number
  description = "Timeout in seconds."
  default     = 30
}

variable "architectures" {
  type        = list(string)
  description = "Instruction set architecture (x86_64 or arm64)."
  default     = ["x86_64"]
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables for the function."
  default     = {}
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "Reserved concurrency (-1 for unreserved)."
  default     = -1
}

variable "log_retention_days" {
  type        = number
  description = "CloudWatch log retention in days."
  default     = 14
}

variable "additional_policy_arns" {
  type        = list(string)
  description = "Additional IAM managed policy ARNs to attach to the Lambda role."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags for Lambda and IAM resources."
  default     = {}
}
