variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# Cross-account provider variables
variable "assume_role_arn_acct_792373136340" {
  type        = string
  description = "IAM role ARN to assume in account 792373136340"
}

variable "assume_role_external_id_acct_792373136340" {
  type        = string
  description = "External ID for assume role in account 792373136340"
  default     = ""
}

# Existing resource variables
variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name"
  default     = "test-crossaccount-opsera-demo"
}

# VPC variables
variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "vpc_availability_zones" {
  type        = list(string)
  description = "VPC availability zones"
}

variable "vpc_public_subnet_cidrs" {
  type        = list(string)
  description = "VPC public subnet CIDRs"
}

variable "vpc_private_subnet_cidrs" {
  type        = list(string)
  description = "VPC private subnet CIDRs"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "VPC enable NAT gateway"
}

variable "vpc_single_nat_gateway" {
  type        = bool
  description = "VPC single NAT gateway"
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "VPC enable DNS hostnames"
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "VPC enable DNS support"
}

variable "vpc_map_public_ip_on_launch" {
  type        = bool
  description = "VPC map public IP on launch"
}

variable "vpc_tags" {
  type        = map(string)
  description = "VPC tags"
  default     = {}
}

# Subnet variables
variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "subnet_cidr_block" {
  type        = string
  description = "Subnet CIDR block"
}

variable "subnet_availability_zone" {
  type        = string
  description = "Subnet availability zone"
}

variable "subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Subnet map public IP on launch"
}

variable "subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Subnet assign IPv6 address on creation"
}

variable "subnet_ipv6_cidr_block" {
  type        = string
  description = "Subnet IPv6 CIDR block"
  default     = null
}

variable "subnet_create_route_table" {
  type        = bool
  description = "Subnet create route table"
}

variable "subnet_route_table_id" {
  type        = string
  description = "Subnet route table ID"
  default     = null
}

variable "subnet_default_route_target_id" {
  type        = string
  description = "Subnet default route target ID"
  default     = null
}

variable "subnet_default_route_target_type" {
  type        = string
  description = "Subnet default route target type"
}

variable "subnet_additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Subnet additional routes"
  default     = []
}

variable "subnet_tags" {
  type        = map(string)
  description = "Subnet tags"
  default     = {}
}

# Security group variables
variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "security_group_description" {
  type        = string
  description = "Security group description"
}

variable "security_group_ingress_rules" {
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Security group ingress rules"
  default     = []
}

variable "security_group_egress_rules" {
  type = list(object({
    description      = optional(string, "")
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), [])
    ipv6_cidr_blocks = optional(list(string), [])
    security_groups  = optional(list(string), [])
    self             = optional(bool, false)
  }))
  description = "Security group egress rules"
  default     = []
}

variable "security_group_default_egress_allow_all" {
  type        = bool
  description = "Security group default egress allow all"
}

variable "security_group_revoke_rules_on_delete" {
  type        = bool
  description = "Security group revoke rules on delete"
}

variable "security_group_tags" {
  type        = map(string)
  description = "Security group tags"
  default     = {}
}

# IAM role variables
variable "iam_role_name" {
  type        = string
  description = "IAM role name"
}

variable "iam_role_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "IAM role assume role principals"
}

variable "iam_role_description" {
  type        = string
  description = "IAM role description"
}

variable "iam_role_path" {
  type        = string
  description = "IAM role path"
}

variable "iam_role_max_session_duration" {
  type        = number
  description = "IAM role max session duration"
}

variable "iam_role_managed_policy_arns" {
  type        = list(string)
  description = "IAM role managed policy ARNs"
  default     = []
}

variable "iam_role_inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "IAM role inline policies"
  default     = {}
}

variable "iam_role_permissions_boundary" {
  type        = string
  description = "IAM role permissions boundary"
  default     = null
}

variable "iam_role_force_detach_policies" {
  type        = bool
  description = "IAM role force detach policies"
}

variable "iam_role_tags" {
  type        = map(string)
  description = "IAM role tags"
  default     = {}
}

# ECR variables
variable "ecr_name" {
  type        = string
  description = "ECR repository name"
}

variable "ecr_image_tag_mutability" {
  type        = string
  description = "ECR image tag mutability"
}

variable "ecr_scan_on_push" {
  type        = bool
  description = "ECR scan on push"
}

variable "ecr_encryption_type" {
  type        = string
  description = "ECR encryption type"
}

variable "ecr_kms_key_arn" {
  type        = string
  description = "ECR KMS key ARN"
  default     = null
}

variable "ecr_force_delete" {
  type        = bool
  description = "ECR force delete"
}

variable "ecr_lifecycle_policy" {
  type        = string
  description = "ECR lifecycle policy"
  default     = null
}

variable "ecr_repository_policy" {
  type        = string
  description = "ECR repository policy"
  default     = null
}

variable "ecr_replication_destinations" {
  type = list(object({
    region      = string
    registry_id = string
  }))
  description = "ECR replication destinations"
  default     = []
}

variable "ecr_replication_filters" {
  type = list(object({
    filter      = string
    filter_type = string
  }))
  description = "ECR replication filters"
  default     = []
}

variable "ecr_tags" {
  type        = map(string)
  description = "ECR tags"
  default     = {}
}

# CloudWatch variables
variable "log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "CloudWatch log groups"
  default     = {}
}

variable "metric_alarms" {
  type = map(object({
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    alarm_description   = optional(string, "")
    alarm_actions       = optional(list(string), [])
    ok_actions          = optional(list(string), [])
    treat_missing_data  = optional(string, "missing")
    datapoints_to_alarm = optional(number, null)
    dimensions          = optional(map(string), null)
    unit                = optional(string, null)
    tags                = optional(map(string), {})
  }))
  description = "CloudWatch metric alarms"
  default     = {}
}

variable "dashboards" {
  type = map(object({
    dashboard_name = string
    dashboard_body = string
  }))
  description = "CloudWatch dashboards"
  default     = {}
}

variable "log_streams" {
  type = map(object({
    name           = string
    log_group_name = string
  }))
  description = "CloudWatch log streams"
  default     = {}
}

variable "event_rules" {
  type = map(object({
    name                = string
    description         = optional(string, "")
    event_pattern       = optional(string, null)
    schedule_expression = optional(string, null)
    state               = optional(string, "ENABLED")
    tags                = optional(map(string), {})
  }))
  description = "CloudWatch event rules"
  default     = {}
}

variable "event_targets" {
  type = map(object({
    rule      = string
    target_id = string
    arn       = string
    role_arn  = optional(string, null)
  }))
  description = "CloudWatch event targets"
  default     = {}
}

variable "cloudwatch_tags" {
  type        = map(string)
  description = "CloudWatch tags"
  default     = {}
}

# Lambda variables
variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_environment" {
  type        = string
  description = "Lambda environment"
}

variable "lambda_description" {
  type        = string
  description = "Lambda description"
}

variable "lambda_tags" {
  type        = map(string)
  description = "Lambda tags"
  default     = {}
}

variable "lambda_package_type" {
  type        = string
  description = "Lambda package type"
}

variable "lambda_image_uri" {
  type        = string
  # Placeholder — replaced by CI/CD pipeline after first image push
  description = "Lambda image URI"
  default     = "472496548172.dkr.ecr.us-east-1.amazonaws.com/lambda-container-repo:latest"
}

variable "lambda_architecture" {
  type        = string
  description = "Lambda architecture"
}

variable "lambda_memory_size" {
  type        = number
  description = "Lambda memory size"
}

variable "lambda_timeout" {
  type        = number
  description = "Lambda timeout"
}

variable "lambda_reserved_concurrent_executions" {
  type        = number
  description = "Lambda reserved concurrent executions"
}

variable "lambda_layers" {
  type        = list(string)
  description = "Lambda layers"
  default     = []
}

variable "lambda_publish" {
  type        = bool
  description = "Lambda publish"
}

variable "lambda_environment_variables" {
  type        = map(string)
  description = "Lambda environment variables"
  default     = {}
}

variable "lambda_create_iam_role" {
  type        = bool
  description = "Lambda create IAM role"
}

variable "lambda_iam_role_name" {
  type        = string
  description = "Lambda IAM role name"
}

variable "lambda_existing_iam_role_arn" {
  type        = string
  description = "Lambda existing IAM role ARN"
  default     = null
}

variable "lambda_additional_policy_arns" {
  type        = list(string)
  description = "Lambda additional policy ARNs"
  default     = []
}

variable "lambda_inline_policy_json" {
  type        = string
  description = "Lambda inline policy JSON"
  default     = null
}

variable "lambda_create_cloudwatch_log_group" {
  type        = bool
  description = "Lambda create CloudWatch log group"
}

variable "lambda_log_retention_in_days" {
  type        = number
  description = "Lambda log retention in days"
}

variable "lambda_log_kms_key_id" {
  type        = string
  description = "Lambda log KMS key ID"
  default     = null
}

variable "lambda_tracing_mode" {
  type        = string
  description = "Lambda tracing mode"
  default     = null
}

variable "lambda_dead_letter_target_arn" {
  type        = string
  description = "Lambda dead letter target ARN"
  default     = null
}

variable "lambda_aliases" {
  type = map(object({
    description              = optional(string)
    function_version         = optional(string, "$LATEST")
    additional_version_weights = optional(map(number))
  }))
  description = "Lambda aliases"
  default     = {}
}

variable "lambda_create_function_url" {
  type        = bool
  description = "Lambda create function URL"
}

variable "lambda_function_url_authorization_type" {
  type        = string
  description = "Lambda function URL authorization type"
}

variable "lambda_permissions" {
  type = map(object({
    action             = optional(string, "lambda:InvokeFunction")
    principal          = string
    source_arn         = optional(string)
    source_account     = optional(string)
    qualifier          = optional(string)
    event_source_token = optional(string)
  }))
  description = "Lambda permissions"
  default     = {}
}

variable "lambda_event_source_mappings" {
  type = map(object({
    event_source_arn  = string
    enabled           = optional(bool, true)
    batch_size        = optional(number)
    starting_position = optional(string)
    filter_patterns   = optional(list(string))
  }))
  description = "Lambda event source mappings"
  default     = {}
}


# --- Variables for resource policy injection ---

variable "existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name" {
  description = "Name of the existing S3 bucket for policy attachment"
  type        = string
  default     = "test-crossaccount-opsera-demo"
}
