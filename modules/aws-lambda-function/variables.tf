variable "function_name" {
  description = "The unique name for the Lambda function."
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

# --- Runtime & Handler ---

variable "runtime" {
  description = "The runtime identifier for the Lambda function (e.g. python3.12, nodejs20.x, java21)."
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
    error_message = "Unsupported runtime specified. Please use a currently supported AWS Lambda runtime."
  }
}

variable "handler" {
  description = "The function entrypoint in the code (e.g. index.handler). Not required for container image deployments."
  type        = string
  default     = null
}

variable "architecture" {
  description = "The instruction set architecture for the Lambda function. Valid values: x86_64, arm64."
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "Architecture must be one of: x86_64, arm64."
  }
}

variable "package_type" {
  description = "The Lambda deployment package type. Valid values: Zip, Image."
  type        = string
  default     = "Zip"

  validation {
    condition     = contains(["Zip", "Image"], var.package_type)
    error_message = "Package type must be one of: Zip, Image."
  }
}

# --- Deployment Package ---

variable "filename" {
  description = "Path to the local .zip file containing the Lambda deployment package. Conflicts with s3_bucket/s3_key and image_uri."
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
  description = "S3 key of the Lambda deployment package. Required when using S3 deployment."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "S3 object version of the Lambda deployment package."
  type        = string
  default     = null
}

variable "image_uri" {
  description = "ECR image URI for container image Lambda deployments."
  type        = string
  default     = null
}

# --- Performance & Concurrency ---

variable "timeout" {
  description = "The maximum execution time in seconds for the Lambda function (1-900)."
  type        = number
  default     = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "Timeout must be between 1 and 900 seconds."
  }
}

variable "memory_size" {
  description = "The amount of memory in MB allocated to the Lambda function (128-10240)."
  type        = number
  default     = 128

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "Memory size must be between 128 and 10240 MB."
  }
}

variable "reserved_concurrent_executions" {
  description = "The number of reserved concurrent executions for the Lambda function. Set to -1 to remove reserved concurrency, or null to use unreserved concurrency."
  type        = number
  default     = null
}

variable "ephemeral_storage_size" {
  description = "The size in MB of the /tmp directory for the Lambda function (512-10240). Leave null to use the default 512 MB."
  type        = number
  default     = null

  validation {
    condition     = var.ephemeral_storage_size == null || (var.ephemeral_storage_size >= 512 && var.ephemeral_storage_size <= 10240)
    error_message = "Ephemeral storage size must be between 512 and 10240 MB."
  }
}

# --- Environment & Layers ---

variable "environment_variables" {
  description = "A map of environment variables to set for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "layer_arns" {
  description = "A list of Lambda layer ARNs to attach to the function (maximum 5)."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.layer_arns) <= 5
    error_message = "A Lambda function can have at most 5 layers."
  }
}

# --- IAM ---

variable "create_iam_role" {
  description = "Whether to create an IAM execution role for the Lambda function. Set to false to provide an existing role via existing_role_arn."
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "Override name for the IAM execution role. Defaults to <function_name>-role."
  type        = string
  default     = null
}

variable "existing_role_arn" {
  description = "ARN of an existing IAM role to use when create_iam_role is false."
  type        = string
  default     = null
}

variable "permissions_boundary_arn" {
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

# --- VPC ---

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for VPC-connected Lambda functions. Leave null to deploy outside a VPC."
  type        = list(string)
  default     = null
}

variable "vpc_id" {
  description = "VPC ID for the Lambda security group. Required when create_security_group is true."
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of additional security group IDs to attach to the VPC-connected Lambda function."
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Whether to create a dedicated security group for the Lambda function. Only applicable when vpc_subnet_ids is set."
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Override name for the Lambda security group. Defaults to <function_name>-sg."
  type        = string
  default     = null
}

# --- Logging ---

variable "create_cloudwatch_log_group" {
  description = "Whether to create a CloudWatch log group for the Lambda function."
  type        = bool
  default     = true
}

variable "log_retention_in_days" {
  description = "Number of days to retain Lambda CloudWatch logs. Set to 0 for indefinite retention."
  type        = number
  default     = 14

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_retention_in_days)
    error_message = "log_retention_in_days must be a valid CloudWatch Logs retention value."
  }
}

variable "log_kms_key_id" {
  description = "KMS key ARN for encrypting the CloudWatch log group."
  type        = string
  default     = null
}

# --- Encryption & Security ---

variable "kms_key_arn" {
  description = "KMS key ARN for encrypting Lambda environment variables."
  type        = string
  default     = null
}

variable "tracing_mode" {
  description = "AWS X-Ray tracing mode. Valid values: PassThrough, Active."
  type        = string
  default     = null

  validation {
    condition     = var.tracing_mode == null || contains(["PassThrough", "Active"], var.tracing_mode)
    error_message = "Tracing mode must be one of: PassThrough, Active."
  }
}

# --- Dead Letter Queue ---

variable "dead_letter_target_arn" {
  description = "ARN of an SQS queue or SNS topic to use as the dead letter queue for failed Lambda invocations."
  type        = string
  default     = null
}

# --- File System (EFS) ---

variable "file_system_arn" {
  description = "ARN of the EFS access point to mount to the Lambda function."
  type        = string
  default     = null
}

variable "file_system_local_mount_path" {
  description = "Local mount path for the EFS file system (must start with /mnt/)."
  type        = string
  default     = null

  validation {
    condition     = var.file_system_local_mount_path == null || can(regex("^/mnt/", var.file_system_local_mount_path))
    error_message = "file_system_local_mount_path must start with /mnt/."
  }
}

# --- Versioning & Aliases ---

variable "publish" {
  description = "Whether to publish a new Lambda version on each deployment."
  type        = bool
  default     = false
}

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

# --- Snap Start ---

variable "snap_start_enabled" {
  description = "Whether to enable SnapStart for the Lambda function (Java runtimes only, requires publish = true)."
  type        = bool
  default     = false
}

# --- Function URL ---

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
    error_message = "function_url_authorization_type must be one of: NONE, AWS_IAM."
  }
}

variable "function_url_cors" {
  description = "CORS configuration for the Lambda function URL. Supported keys: allow_credentials, allow_headers, allow_methods, allow_origins, expose_headers, max_age."
  type        = any
  default     = null
}

# --- Triggers & Event Sources ---

variable "allowed_triggers" {
  description = "Map of Lambda permission configurations for allowed triggers. Each entry requires a 'principal' key and optionally 'source_arn', 'source_account', and 'event_source_token'."
  type        = map(any)
  default     = {}
}

variable "event_source_mappings" {
  description = "Map of event source mapping configurations (SQS, DynamoDB, Kinesis, etc.). Each entry requires 'event_source_arn'. Optional keys: enabled, batch_size, maximum_batching_window_in_seconds, starting_position, bisect_batch_on_function_error, maximum_record_age_in_seconds, maximum_retry_attempts, parallelization_factor, tumbling_window_in_seconds, function_response_types, on_failure_destination_arn, filter_patterns."
  type        = map(any)
  default     = {}
}
