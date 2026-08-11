variable "function_name" {
  description = "The unique name for the Lambda function."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,64}$", var.function_name))
    error_message = "function_name must be 1-64 characters and contain only letters, numbers, hyphens, and underscores."
  }
}

variable "description" {
  description = "A description of the Lambda function."
  type        = string
  default     = ""
}

variable "runtime" {
  description = "The runtime identifier for the Lambda function (e.g. python3.12, nodejs20.x). Not required when package_type is Image."
  type        = string
  default     = null

  validation {
    condition = var.runtime == null || contains([
      "nodejs18.x", "nodejs20.x",
      "python3.10", "python3.11", "python3.12",
      "java11", "java17", "java21",
      "dotnet6", "dotnet8",
      "ruby3.2", "ruby3.3",
      "provided.al2", "provided.al2023"
    ], var.runtime)
    error_message = "runtime must be a supported AWS Lambda runtime identifier or null for container images."
  }
}

variable "handler" {
  description = "The function entrypoint in your code (e.g. index.handler). Not required when package_type is Image."
  type        = string
  default     = null
}

variable "architecture" {
  description = "The instruction set architecture for the Lambda function. Valid values: x86_64, arm64."
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "architecture must be either x86_64 or arm64."
  }
}

variable "package_type" {
  description = "The Lambda deployment package type. Valid values: Zip, Image."
  type        = string
  default     = "Zip"

  validation {
    condition     = contains(["Zip", "Image"], var.package_type)
    error_message = "package_type must be either Zip or Image."
  }
}

variable "filename" {
  description = "Path to the local zip file containing the Lambda deployment package. Conflicts with s3_bucket/s3_key and image_uri."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Base64-encoded SHA256 hash of the deployment package. Used to detect changes when filename is set."
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "S3 bucket containing the Lambda deployment package. Required when using S3 deployment."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 key of the Lambda deployment package. Required when s3_bucket is set."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "S3 object version of the Lambda deployment package."
  type        = string
  default     = null
}

variable "image_uri" {
  description = "ECR image URI for the Lambda container image. Required when package_type is Image."
  type        = string
  default     = null
}

variable "timeout" {
  description = "The maximum number of seconds the Lambda function is allowed to run. Valid range: 1-900."
  type        = number
  default     = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "timeout must be between 1 and 900 seconds."
  }
}

variable "memory_size" {
  description = "The amount of memory (in MB) available to the Lambda function at runtime. Valid range: 128-10240."
  type        = number
  default     = 128

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "memory_size must be between 128 and 10240 MB."
  }
}

variable "ephemeral_storage_size" {
  description = "The size (in MB) of the /tmp directory available to the Lambda function. Valid range: 512-10240."
  type        = number
  default     = null

  validation {
    condition     = var.ephemeral_storage_size == null || (var.ephemeral_storage_size >= 512 && var.ephemeral_storage_size <= 10240)
    error_message = "ephemeral_storage_size must be between 512 and 10240 MB."
  }
}

variable "reserved_concurrent_executions" {
  description = "The number of simultaneous executions to reserve for the Lambda function. Set to -1 to remove reserved concurrency."
  type        = number
  default     = -1
}

variable "publish" {
  description = "Whether to publish a new Lambda function version on each deployment."
  type        = bool
  default     = false
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "layer_arns" {
  description = "List of Lambda layer ARNs to attach to the function (maximum 5)."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.layer_arns) <= 5
    error_message = "A Lambda function can have at most 5 layers."
  }
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the Lambda function's environment variables."
  type        = string
  default     = null
}

variable "tracing_mode" {
  description = "AWS X-Ray tracing mode. Valid values: PassThrough, Active."
  type        = string
  default     = null

  validation {
    condition     = var.tracing_mode == null || contains(["PassThrough", "Active"], var.tracing_mode)
    error_message = "tracing_mode must be PassThrough or Active."
  }
}

variable "dead_letter_target_arn" {
  description = "ARN of an SNS topic or SQS queue to use as the dead-letter queue for failed Lambda invocations."
  type        = string
  default     = null
}

variable "snap_start_enabled" {
  description = "Whether to enable SnapStart for the Lambda function (supported on Java runtimes with published versions)."
  type        = bool
  default     = false
}

# VPC
variable "vpc_subnet_ids" {
  description = "List of subnet IDs to attach the Lambda function to when running inside a VPC."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to attach to the Lambda function when running inside a VPC."
  type        = list(string)
  default     = null
}

# EFS
variable "file_system_arn" {
  description = "ARN of the EFS access point to mount to the Lambda function."
  type        = string
  default     = null
}

variable "file_system_local_mount_path" {
  description = "Local mount path for the EFS file system inside the Lambda function (must start with /mnt/)."
  type        = string
  default     = null

  validation {
    condition     = var.file_system_local_mount_path == null || startswith(var.file_system_local_mount_path, "/mnt/")
    error_message = "file_system_local_mount_path must start with /mnt/."
  }
}

# IAM
variable "create_iam_role" {
  description = "Whether to create a new IAM execution role for the Lambda function. Set to false to provide an existing role via existing_role_arn."
  type        = bool
  default     = true
}

variable "existing_role_arn" {
  description = "ARN of an existing IAM role to use for the Lambda function. Required when create_iam_role is false."
  type        = string
  default     = null
}

variable "role_permissions_boundary_arn" {
  description = "ARN of the IAM permissions boundary policy to attach to the Lambda execution role."
  type        = string
  default     = null
}

variable "additional_policy_arns" {
  description = "List of additional IAM policy ARNs to attach to the Lambda execution role."
  type        = list(string)
  default     = []
}

variable "inline_policy_json" {
  description = "JSON-encoded inline IAM policy to attach to the Lambda execution role."
  type        = string
  default     = null
}

# CloudWatch Logs
variable "create_cloudwatch_log_group" {
  description = "Whether to create a CloudWatch log group for the Lambda function."
  type        = bool
  default     = true
}

variable "log_retention_in_days" {
  description = "Number of days to retain Lambda function logs in CloudWatch. Set to 0 for indefinite retention."
  type        = number
  default     = 14

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_retention_in_days)
    error_message = "log_retention_in_days must be a valid CloudWatch Logs retention period value."
  }
}

variable "log_kms_key_id" {
  description = "ARN of the KMS key to use for encrypting the Lambda CloudWatch log group."
  type        = string
  default     = null
}

# Alias
variable "create_alias" {
  description = "Whether to create a Lambda alias."
  type        = bool
  default     = false
}

variable "alias_name" {
  description = "Name of the Lambda alias. Required when create_alias is true."
  type        = string
  default     = "live"
}

variable "alias_description" {
  description = "Description of the Lambda alias."
  type        = string
  default     = ""
}

variable "alias_function_version" {
  description = "Lambda function version the alias points to. Defaults to the version published by the current deployment."
  type        = string
  default     = null
}

# Provisioned Concurrency
variable "provisioned_concurrent_executions" {
  description = "Number of provisioned concurrency executions to allocate to the Lambda alias. Requires create_alias = true."
  type        = number
  default     = null

  validation {
    condition     = var.provisioned_concurrent_executions == null || var.provisioned_concurrent_executions > 0
    error_message = "provisioned_concurrent_executions must be a positive integer."
  }
}

# Function URL
variable "create_function_url" {
  description = "Whether to create a Lambda function URL."
  type        = bool
  default     = false
}

variable "function_url_authorization_type" {
  description = "Authorization type for the Lambda function URL. Valid values: NONE, AWS_IAM."
  type        = string
  default     = "AWS_IAM"

  validation {
    condition     = contains(["NONE", "AWS_IAM"], var.function_url_authorization_type)
    error_message = "function_url_authorization_type must be NONE or AWS_IAM."
  }
}

variable "function_url_cors" {
  description = "CORS configuration for the Lambda function URL. Keys: allow_credentials, allow_headers, allow_methods, allow_origins, expose_headers, max_age."
  type        = any
  default     = null
}

# Triggers / Permissions
variable "allowed_triggers" {
  description = "Map of Lambda permission configurations keyed by statement ID. Each value must include 'principal' and optionally 'source_arn' and 'source_account'."
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "A map of tags to apply to all resources created by this module."
  type        = map(string)
  default     = {}
}
