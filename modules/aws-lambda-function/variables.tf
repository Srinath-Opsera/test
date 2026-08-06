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

# --- Package Configuration ---

variable "package_type" {
  description = "The Lambda deployment package type. Valid values are Zip or Image."
  type        = string
  default     = "Zip"

  validation {
    condition     = contains(["Zip", "Image"], var.package_type)
    error_message = "package_type must be either 'Zip' or 'Image'."
  }
}

variable "filename" {
  description = "Path to the local zip file to use as the Lambda deployment package. Conflicts with s3_bucket/s3_key."
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "S3 bucket containing the Lambda deployment package. Used when filename is null."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 key of the Lambda deployment package. Used when filename is null."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "S3 object version of the Lambda deployment package."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Base64-encoded SHA256 hash of the package file. Used to trigger updates."
  type        = string
  default     = null
}

variable "image_uri" {
  description = "ECR image URI for the Lambda function. Required when package_type is Image."
  type        = string
  default     = null
}

variable "image_command" {
  description = "Container image command override (list of strings)."
  type        = list(string)
  default     = null
}

variable "image_entry_point" {
  description = "Container image entry point override (list of strings)."
  type        = list(string)
  default     = null
}

variable "image_working_directory" {
  description = "Container image working directory override."
  type        = string
  default     = null
}

# --- Runtime Configuration ---

variable "runtime" {
  description = "The Lambda runtime identifier. Required when package_type is Zip."
  type        = string
  default     = null

  validation {
    condition = var.runtime == null || contains([
      "nodejs18.x", "nodejs20.x",
      "python3.9", "python3.10", "python3.11", "python3.12",
      "java11", "java17", "java21",
      "dotnet6", "dotnet8",
      "ruby3.2", "ruby3.3",
      "provided.al2", "provided.al2023"
    ], var.runtime)
    error_message = "runtime must be a valid AWS Lambda runtime identifier."
  }
}

variable "handler" {
  description = "The function entrypoint in your code. Required when package_type is Zip."
  type        = string
  default     = null
}

variable "architecture" {
  description = "The instruction set architecture for the Lambda function. Valid values are x86_64 or arm64."
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "architecture must be either 'x86_64' or 'arm64'."
  }
}

variable "memory_size" {
  description = "Amount of memory in MB the Lambda function can use at runtime. Between 128 and 10240."
  type        = number
  default     = 128

  validation {
    condition     = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "memory_size must be between 128 and 10240 MB."
  }
}

variable "timeout" {
  description = "The amount of time the Lambda function has to run in seconds. Between 1 and 900."
  type        = number
  default     = 30

  validation {
    condition     = var.timeout >= 1 && var.timeout <= 900
    error_message = "timeout must be between 1 and 900 seconds."
  }
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for the Lambda function. Set to -1 to remove the limit."
  type        = number
  default     = -1
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

variable "publish" {
  description = "Whether to publish a new Lambda function version on each update."
  type        = bool
  default     = false
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "ephemeral_storage_size" {
  description = "The size of the Lambda function's /tmp directory in MB. Between 512 and 10240."
  type        = number
  default     = null

  validation {
    condition     = var.ephemeral_storage_size == null || (var.ephemeral_storage_size >= 512 && var.ephemeral_storage_size <= 10240)
    error_message = "ephemeral_storage_size must be between 512 and 10240 MB."
  }
}

variable "snap_start_apply_on" {
  description = "Conditions where snap start is enabled. Valid values are PublishedVersions or None."
  type        = string
  default     = null

  validation {
    condition     = var.snap_start_apply_on == null || contains(["PublishedVersions", "None"], var.snap_start_apply_on)
    error_message = "snap_start_apply_on must be either 'PublishedVersions' or 'None'."
  }
}

# --- IAM Configuration ---

variable "create_iam_role" {
  description = "Whether to create an IAM execution role for the Lambda function."
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "Name for the IAM execution role. Defaults to <function_name>-role."
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
  description = "JSON string of an inline IAM policy to attach to the Lambda execution role."
  type        = string
  default     = null
}

# --- VPC Configuration ---

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for the Lambda function when running inside a VPC."
  type        = list(string)
  default     = null
}

variable "vpc_id" {
  description = "VPC ID for the Lambda security group. Required when create_security_group is true."
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of existing security group IDs for the Lambda function in a VPC. Used when create_security_group is false."
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Whether to create a security group for the Lambda function. Only applicable when vpc_subnet_ids is set."
  type        = bool
  default     = false
}

variable "security_group_name" {
  description = "Name for the Lambda security group. Defaults to <function_name>-sg."
  type        = string
  default     = null
}

variable "security_group_ingress_rules" {
  description = "List of ingress rules for the Lambda security group."
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))
  default = []
}

variable "security_group_egress_rules" {
  description = "List of egress rules for the Lambda security group."
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))
  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# --- Observability ---

variable "create_cloudwatch_log_group" {
  description = "Whether to create a CloudWatch log group for the Lambda function."
  type        = bool
  default     = true
}

variable "log_retention_in_days" {
  description = "Number of days to retain Lambda CloudWatch logs. 0 means never expire."
  type        = number
  default     = 14

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_retention_in_days)
    error_message = "log_retention_in_days must be a valid CloudWatch Logs retention value."
  }
}

variable "log_kms_key_id" {
  description = "KMS key ARN to encrypt the CloudWatch log group."
  type        = string
  default     = null
}

variable "tracing_mode" {
  description = "X-Ray tracing mode for the Lambda function. Valid values are PassThrough or Active."
  type        = string
  default     = null

  validation {
    condition     = var.tracing_mode == null || contains(["PassThrough", "Active"], var.tracing_mode)
    error_message = "tracing_mode must be either 'PassThrough' or 'Active'."
  }
}

# --- Dead Letter Queue ---

variable "dead_letter_target_arn" {
  description = "ARN of an SQS queue or SNS topic to use as the dead letter queue."
  type        = string
  default     = null
}

# --- File System ---

variable "file_system_arn" {
  description = "ARN of the EFS access point to mount on the Lambda function."
  type        = string
  default     = null
}

variable "file_system_local_mount_path" {
  description = "Local mount path for the EFS file system. Must start with /mnt/."
  type        = string
  default     = null

  validation {
    condition     = var.file_system_local_mount_path == null || can(regex("^/mnt/", var.file_system_local_mount_path))
    error_message = "file_system_local_mount_path must start with /mnt/."
  }
}

# --- Aliases ---

variable "aliases" {
  description = "Map of Lambda aliases to create. Key is alias name, value is configuration object."
  type = map(object({
    description              = optional(string)
    function_version         = optional(string, "$LATEST")
    additional_version_weights = optional(map(number))
  }))
  default = {}
}

# --- Function URL ---

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
    error_message = "function_url_authorization_type must be either 'NONE' or 'AWS_IAM'."
  }
}

variable "function_url_qualifier" {
  description = "The alias or version to attach the function URL to."
  type        = string
  default     = null
}

variable "function_url_cors" {
  description = "CORS configuration for the Lambda function URL."
  type = object({
    allow_credentials = optional(bool)
    allow_headers     = optional(list(string))
    allow_methods     = optional(list(string))
    allow_origins     = optional(list(string))
    expose_headers    = optional(list(string))
    max_age           = optional(number)
  })
  default = null
}

# --- Permissions ---

variable "lambda_permissions" {
  description = "Map of Lambda permission statements to create. Key is the statement ID."
  type = map(object({
    action             = optional(string, "lambda:InvokeFunction")
    principal          = string
    source_arn         = optional(string)
    source_account     = optional(string)
    qualifier          = optional(string)
    event_source_token = optional(string)
  }))
  default = {}
}

# --- Event Source Mappings ---

variable "event_source_mappings" {
  description = "Map of event source mappings to create for the Lambda function."
  type = map(object({
    event_source_arn  = string
    enabled           = optional(bool, true)
    batch_size        = optional(number)
    starting_position = optional(string)
    filter_patterns   = optional(list(string))
  }))
  default = {}
}
