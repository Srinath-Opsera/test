variable "function_name" {
  description = "The unique name for the Lambda function."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,64}$", var.function_name))
    error_message = "function_name must be 1-64 characters and contain only letters, numbers, hyphens, and underscores."
  }
}

variable "environment" {
  description = "The deployment environment (e.g. dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod", "test", "qa"], var.environment)
    error_message = "environment must be one of: dev, staging, prod, test, qa."
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

# --- Runtime / Package ---

variable "package_type" {
  description = "The Lambda deployment package type. Valid values: Zip, Image."
  type        = string
  default     = "Zip"

  validation {
    condition     = contains(["Zip", "Image"], var.package_type)
    error_message = "package_type must be either 'Zip' or 'Image'."
  }
}

variable "runtime" {
  description = "The Lambda runtime identifier (required when package_type is Zip)."
  type        = string
  default     = "python3.12"
}

variable "handler" {
  description = "The function entrypoint in the format file.method (required when package_type is Zip)."
  type        = string
  default     = "index.handler"
}

variable "architecture" {
  description = "The instruction set architecture for the Lambda function. Valid values: x86_64, arm64."
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "architecture must be either 'x86_64' or 'arm64'."
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
  description = "S3 bucket containing the Lambda deployment package."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 key of the Lambda deployment package."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "S3 object version of the Lambda deployment package."
  type        = string
  default     = null
}

variable "image_uri" {
  description = "ECR image URI to use for the Lambda function (required when package_type is Image)."
  type        = string
  default     = null
}

variable "image_config" {
  description = "Container image configuration for Image package type. Supports keys: command (list), entry_point (list), working_directory (string)."
  type        = map(any)
  default     = null
}

# --- Compute ---

variable "timeout" {
  description = "The maximum number of seconds the Lambda function is allowed to run (1-900)."
  type        = number
  default     = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "timeout must be between 1 and 900 seconds."
  }
}

variable "memory_size" {
  description = "The amount of memory (in MB) allocated to the Lambda function (128-10240)."
  type        = number
  default     = 128

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "memory_size must be between 128 and 10240 MB."
  }
}

variable "reserved_concurrent_executions" {
  description = "The number of concurrent executions reserved for the function. Set to -1 to remove any reserved concurrency."
  type        = number
  default     = -1
}

variable "publish" {
  description = "Whether to publish a new Lambda function version on each deployment."
  type        = bool
  default     = false
}

variable "layers" {
  description = "List of Lambda layer ARNs to attach to the function (maximum 5)."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.layers) <= 5
    error_message = "A Lambda function can have at most 5 layers."
  }
}

# --- Environment Variables ---

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = {}
}

# --- IAM ---

variable "create_iam_role" {
  description = "Whether to create a new IAM execution role for the Lambda function."
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "Override name for the IAM execution role. Defaults to '<function_name>-role'."
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the IAM policy to use as a permissions boundary for the execution role."
  type        = string
  default     = null
}

variable "existing_iam_role_arn" {
  description = "ARN of an existing IAM role to use when create_iam_role is false."
  type        = string
  default     = null
}

variable "additional_policy_arns" {
  description = "List of additional IAM policy ARNs to attach to the Lambda execution role."
  type        = list(string)
  default     = []
}

variable "inline_policy_json" {
  description = "JSON-encoded IAM policy document to create and attach as an inline policy on the execution role."
  type        = string
  default     = null
}

# --- VPC ---

variable "vpc_id" {
  description = "VPC ID for the Lambda function. Required when vpc_subnet_ids is set and create_security_group is true."
  type        = string
  default     = null
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for the Lambda VPC configuration."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of additional security group IDs for the Lambda VPC configuration."
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Whether to create a dedicated security group for the Lambda function (only applies when vpc_subnet_ids is set)."
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Override name for the Lambda security group. Defaults to '<function_name>-sg'."
  type        = string
  default     = null
}

# --- CloudWatch Logs ---

variable "create_cloudwatch_log_group" {
  description = "Whether to create a CloudWatch log group for the Lambda function."
  type        = bool
  default     = true
}

variable "cloudwatch_logs_retention_days" {
  description = "Number of days to retain Lambda CloudWatch logs. 0 means never expire."
  type        = number
  default     = 14

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.cloudwatch_logs_retention_days)
    error_message = "cloudwatch_logs_retention_days must be a valid CloudWatch retention period value."
  }
}

variable "cloudwatch_logs_kms_key_id" {
  description = "ARN of the KMS key to use for encrypting CloudWatch log data."
  type        = string
  default     = null
}

# --- Encryption ---

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the Lambda function's environment variables."
  type        = string
  default     = null
}

# --- Dead Letter Queue ---

variable "dead_letter_target_arn" {
  description = "ARN of an SQS queue or SNS topic to use as the dead-letter target for failed async invocations."
  type        = string
  default     = null
}

# --- Tracing ---

variable "tracing_mode" {
  description = "AWS X-Ray tracing mode. Valid values: PassThrough, Active."
  type        = string
  default     = null

  validation {
    condition     = var.tracing_mode == null || contains(["PassThrough", "Active"], var.tracing_mode)
    error_message = "tracing_mode must be either 'PassThrough' or 'Active'."
  }
}

# --- EFS ---

variable "file_system_arn" {
  description = "ARN of the EFS access point to mount inside the Lambda function."
  type        = string
  default     = null
}

variable "file_system_local_mount_path" {
  description = "Local mount path for the EFS file system inside the Lambda container (must start with /mnt/)."
  type        = string
  default     = null

  validation {
    condition     = var.file_system_local_mount_path == null || can(regex("^/mnt/", var.file_system_local_mount_path))
    error_message = "file_system_local_mount_path must start with '/mnt/'."
  }
}

# --- Alias ---

variable "create_alias" {
  description = "Whether to create a Lambda alias."
  type        = bool
  default     = false
}

variable "alias_name" {
  description = "Name of the Lambda alias (required when create_alias is true)."
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
    error_message = "function_url_authorization_type must be either 'NONE' or 'AWS_IAM'."
  }
}

variable "function_url_cors" {
  description = "CORS configuration for the Lambda function URL. Supports keys: allow_credentials (bool), allow_headers (list), allow_methods (list), allow_origins (list), expose_headers (list), max_age (number)."
  type        = map(any)
  default     = null
}

# --- Permissions ---

variable "lambda_permissions" {
  description = "List of Lambda permission objects to grant external services invocation rights. Each object must include statement_id and principal, and optionally action, source_arn, source_account, event_source_token."
  type        = list(map(string))
  default     = []
}

# --- Event Source Mappings ---

variable "event_source_mappings" {
  description = "List of event source mapping configurations. Each object must include event_source_arn and may include batch_size, starting_position, enabled, and other supported attributes."
  type        = list(map(any))
  default     = []
}

# --- Snap Start ---

variable "snap_start_apply_on" {
  description = "Snap Start configuration. Valid values: PublishedVersions, None."
  type        = string
  default     = null

  validation {
    condition     = var.snap_start_apply_on == null || contains(["PublishedVersions", "None"], var.snap_start_apply_on)
    error_message = "snap_start_apply_on must be either 'PublishedVersions' or 'None'."
  }
}
