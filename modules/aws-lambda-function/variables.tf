variable "function_name" {
  description = "The name of the Lambda function."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,64}$", var.function_name))
    error_message = "Function name must be 1-64 characters and contain only letters, numbers, hyphens, and underscores."
  }
}

variable "environment" {
  description = "The deployment environment (e.g. dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod", "test", "qa"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, test, qa."
  }
}

variable "description" {
  description = "A description of the Lambda function."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

# Runtime & Handler
variable "runtime" {
  description = "The runtime identifier for the Lambda function (e.g. python3.12, nodejs20.x, java21). Not required for container image deployments."
  type        = string
  default     = null

  validation {
    condition = var.runtime == null || contains([
      "python3.8", "python3.9", "python3.10", "python3.11", "python3.12",
      "nodejs18.x", "nodejs20.x",
      "java11", "java17", "java21",
      "dotnet6", "dotnet8",
      "ruby3.2", "ruby3.3",
      "provided.al2", "provided.al2023"
    ], var.runtime)
    error_message = "Runtime must be a valid AWS Lambda runtime identifier or null for container image deployments."
  }
}

variable "handler" {
  description = "The function entrypoint in your code (e.g. index.handler). Not required for container image deployments."
  type        = string
  default     = null
}

variable "architecture" {
  description = "The instruction set architecture for the Lambda function. Valid values are x86_64 or arm64."
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "Architecture must be either x86_64 or arm64."
  }
}

# Deployment Package - S3
variable "s3_bucket" {
  description = "The S3 bucket containing the Lambda deployment package. Conflicts with filename and image_uri."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "The S3 key of the Lambda deployment package. Required when s3_bucket is set."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "The object version of the S3 deployment package."
  type        = string
  default     = null
}

# Deployment Package - Local
variable "filename" {
  description = "Path to the local zip file containing the Lambda deployment package. Conflicts with s3_bucket and image_uri."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Base64-encoded SHA256 hash of the deployment package. Used to trigger updates when the package changes."
  type        = string
  default     = null
}

# Deployment Package - Container Image
variable "image_uri" {
  description = "The ECR image URI for container image deployments. Conflicts with filename and s3_bucket."
  type        = string
  default     = null
}

# Performance
variable "timeout" {
  description = "The maximum number of seconds the Lambda function can run. Valid range is 1 to 900."
  type        = number
  default     = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "Timeout must be between 1 and 900 seconds."
  }
}

variable "memory_size" {
  description = "The amount of memory in MB available to the Lambda function. Must be a multiple of 64 between 128 and 10240."
  type        = number
  default     = 128

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240 && var.memory_size % 64 == 0
    error_message = "Memory size must be a multiple of 64 between 128 and 10240 MB."
  }
}

variable "reserved_concurrent_executions" {
  description = "The number of reserved concurrent executions for the Lambda function. Set to -1 to remove reserved concurrency, or null for unreserved."
  type        = number
  default     = null
}

variable "ephemeral_storage_size" {
  description = "The size in MB of the /tmp directory available to the Lambda function. Valid range is 512 to 10240."
  type        = number
  default     = null

  validation {
    condition     = var.ephemeral_storage_size == null || (var.ephemeral_storage_size >= 512 && var.ephemeral_storage_size <= 10240)
    error_message = "Ephemeral storage size must be between 512 and 10240 MB."
  }
}

variable "publish" {
  description = "Whether to publish a new Lambda function version on each deployment."
  type        = bool
  default     = false
}

variable "snap_start_enabled" {
  description = "Whether to enable SnapStart for the Lambda function. Only supported for Java runtimes with publish = true."
  type        = bool
  default     = false
}

# Environment Variables
variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = {}
}

# Layers
variable "layer_arns" {
  description = "A list of Lambda layer ARNs to attach to the function. Maximum of 5 layers."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.layer_arns) <= 5
    error_message = "A Lambda function can have at most 5 layers."
  }
}

# IAM Role
variable "create_iam_role" {
  description = "Whether to create an IAM execution role for the Lambda function. Set to false to provide an existing role ARN."
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "The name of the IAM role to create. Defaults to <function_name>-role."
  type        = string
  default     = null
}

variable "existing_role_arn" {
  description = "The ARN of an existing IAM role to use when create_iam_role is false."
  type        = string
  default     = null
}

variable "additional_policy_arns" {
  description = "A list of additional IAM policy ARNs to attach to the Lambda execution role."
  type        = list(string)
  default     = []
}

variable "inline_policy_json" {
  description = "A JSON-encoded inline IAM policy to attach to the Lambda execution role."
  type        = string
  default     = null
}

# VPC
variable "vpc_id" {
  description = "The ID of the VPC to deploy the Lambda function into. Required when vpc_subnet_ids is set and create_security_group is true."
  type        = string
  default     = null
}

variable "vpc_subnet_ids" {
  description = "A list of subnet IDs to deploy the Lambda function into. Enables VPC access."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of existing security group IDs to attach to the Lambda function when deployed in a VPC."
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Whether to create a security group for the Lambda function. Only applicable when vpc_subnet_ids is set."
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "The name of the security group to create. Defaults to <function_name>-sg."
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
  description = "The number of days to retain Lambda function logs in CloudWatch. Set to 0 for indefinite retention."
  type        = number
  default     = 14

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_retention_in_days)
    error_message = "Log retention must be one of the allowed CloudWatch values: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653."
  }
}

# Encryption
variable "kms_key_arn" {
  description = "The ARN of a KMS key to encrypt the Lambda function's environment variables and CloudWatch logs."
  type        = string
  default     = null
}

# Dead Letter Queue
variable "dead_letter_target_arn" {
  description = "The ARN of an SQS queue or SNS topic to use as the dead letter queue for failed Lambda invocations."
  type        = string
  default     = null
}

# X-Ray Tracing
variable "tracing_mode" {
  description = "The X-Ray tracing mode for the Lambda function. Valid values are PassThrough or Active."
  type        = string
  default     = null

  validation {
    condition     = var.tracing_mode == null || contains(["PassThrough", "Active"], var.tracing_mode)
    error_message = "Tracing mode must be either PassThrough or Active."
  }
}

# EFS
variable "file_system_arn" {
  description = "The ARN of an EFS access point to mount to the Lambda function."
  type        = string
  default     = null
}

variable "file_system_local_mount_path" {
  description = "The local mount path for the EFS file system. Must start with /mnt/."
  type        = string
  default     = null

  validation {
    condition     = var.file_system_local_mount_path == null || can(regex("^/mnt/", var.file_system_local_mount_path))
    error_message = "EFS local mount path must start with /mnt/."
  }
}

# Alias
variable "create_alias" {
  description = "Whether to create a Lambda alias."
  type        = bool
  default     = false
}

variable "alias_name" {
  description = "The name of the Lambda alias. Required when create_alias is true."
  type        = string
  default     = "live"
}

variable "alias_description" {
  description = "A description of the Lambda alias."
  type        = string
  default     = ""
}

variable "alias_function_version" {
  description = "The Lambda function version the alias points to. Defaults to the latest published version."
  type        = string
  default     = null
}

# Function URL
variable "create_function_url" {
  description = "Whether to create a Lambda function URL."
  type        = bool
  default     = false
}

variable "function_url_authorization_type" {
  description = "The authorization type for the Lambda function URL. Valid values are NONE or AWS_IAM."
  type        = string
  default     = "AWS_IAM"

  validation {
    condition     = contains(["NONE", "AWS_IAM"], var.function_url_authorization_type)
    error_message = "Function URL authorization type must be either NONE or AWS_IAM."
  }
}

variable "function_url_cors" {
  description = "CORS configuration for the Lambda function URL. Supports keys: allow_credentials, allow_headers, allow_methods, allow_origins, expose_headers, max_age."
  type        = map(any)
  default     = null
}

# Permissions
variable "lambda_permissions" {
  description = "A map of Lambda permission configurations. Each key is the statement_id. Supported keys per entry: principal (required), action, source_arn, source_account, event_source_token."
  type        = map(map(string))
  default     = {}
}

# Event Source Mappings
variable "event_source_mappings" {
  description = "A map of event source mapping configurations. Each key is a unique identifier. Supported keys: event_source_arn (required), enabled, batch_size, starting_position, filter_patterns."
  type        = any
  default     = {}
}

# Provisioned Concurrency Auto Scaling
variable "provisioned_concurrency_config" {
  description = "Auto scaling configuration for provisioned concurrency. Requires create_alias = true. Supported keys: min_capacity, max_capacity."
  type        = map(number)
  default     = null
}
