variable "region" {
  type        = string
  description = "AWS region"
}

# VPC
variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Single NAT gateway"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch"
}

# Internet Gateway
variable "internet_gateway_name" {
  type        = string
  description = "Internet gateway name"
}

# Public Subnet
variable "public_subnet_name" {
  type        = string
  description = "Public subnet name"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Public subnet CIDR block"
}

variable "public_subnet_availability_zone" {
  type        = string
  description = "Public subnet availability zone"
}

variable "public_subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Public subnet map public IP on launch"
}

variable "public_subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Public subnet assign IPv6 address on creation"
}

variable "public_subnet_ipv6_cidr_block" {
  type        = string
  description = "Public subnet IPv6 CIDR block"
  default     = null
}

variable "public_subnet_create_route_table" {
  type        = bool
  description = "Public subnet create route table"
}

variable "public_subnet_default_route_target_id" {
  type        = string
  description = "Public subnet default route target ID"
  default     = null
}

variable "public_subnet_default_route_target_type" {
  type        = string
  description = "Public subnet default route target type"
}

variable "public_subnet_additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Public subnet additional routes"
  default     = []
}

# Private Subnet
variable "private_subnet_name" {
  type        = string
  description = "Private subnet name"
}

variable "private_subnet_cidr_block" {
  type        = string
  description = "Private subnet CIDR block"
}

variable "private_subnet_availability_zone" {
  type        = string
  description = "Private subnet availability zone"
}

variable "private_subnet_map_public_ip_on_launch" {
  type        = bool
  description = "Private subnet map public IP on launch"
}

variable "private_subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Private subnet assign IPv6 address on creation"
}

variable "private_subnet_ipv6_cidr_block" {
  type        = string
  description = "Private subnet IPv6 CIDR block"
  default     = null
}

variable "private_subnet_create_route_table" {
  type        = bool
  description = "Private subnet create route table"
}

variable "private_subnet_default_route_target_id" {
  type        = string
  description = "Private subnet default route target ID"
  default     = null
}

variable "private_subnet_default_route_target_type" {
  type        = string
  description = "Private subnet default route target type"
}

variable "private_subnet_additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Private subnet additional routes"
  default     = []
}

# NAT Gateway
variable "nat_gateway_name" {
  type        = string
  description = "NAT gateway name"
}

variable "nat_gateway_connectivity_type" {
  type        = string
  description = "NAT gateway connectivity type"
}

variable "nat_gateway_create_eip" {
  type        = bool
  description = "NAT gateway create EIP"
}

# ALB Security Group
variable "security_group_alb_name" {
  type        = string
  description = "ALB security group name"
}

variable "security_group_alb_description" {
  type        = string
  description = "ALB security group description"
}

variable "security_group_alb_ingress_rules" {
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
  description = "ALB security group ingress rules"
}

variable "security_group_alb_egress_rules" {
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
  description = "ALB security group egress rules"
  default     = []
}

variable "security_group_alb_default_egress_allow_all" {
  type        = bool
  description = "ALB security group default egress allow all"
}

variable "security_group_alb_revoke_rules_on_delete" {
  type        = bool
  description = "ALB security group revoke rules on delete"
}

# ECS Security Group
variable "security_group_ecs_name" {
  type        = string
  description = "ECS security group name"
}

variable "security_group_ecs_description" {
  type        = string
  description = "ECS security group description"
}

variable "security_group_ecs_ingress_rules" {
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
  description = "ECS security group ingress rules"
}

variable "security_group_ecs_egress_rules" {
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
  description = "ECS security group egress rules"
  default     = []
}

variable "security_group_ecs_default_egress_allow_all" {
  type        = bool
  description = "ECS security group default egress allow all"
}

variable "security_group_ecs_revoke_rules_on_delete" {
  type        = bool
  description = "ECS security group revoke rules on delete"
}

# Lambda Security Group
variable "security_group_lambda_name" {
  type        = string
  description = "Lambda security group name"
}

variable "security_group_lambda_description" {
  type        = string
  description = "Lambda security group description"
}

variable "security_group_lambda_ingress_rules" {
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
  description = "Lambda security group ingress rules"
  default     = []
}

variable "security_group_lambda_egress_rules" {
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
  description = "Lambda security group egress rules"
  default     = []
}

variable "security_group_lambda_default_egress_allow_all" {
  type        = bool
  description = "Lambda security group default egress allow all"
}

variable "security_group_lambda_revoke_rules_on_delete" {
  type        = bool
  description = "Lambda security group revoke rules on delete"
}

# ALB
variable "alb_name" {
  type        = string
  description = "ALB name"
}

variable "alb_certificate_arn" {
  type        = string
  description = "ALB certificate ARN"
}

variable "alb_internal" {
  type        = bool
  description = "ALB internal"
}

variable "alb_enable_deletion_protection" {
  type        = bool
  description = "ALB enable deletion protection"
}

variable "alb_idle_timeout" {
  type        = number
  description = "ALB idle timeout"
}

variable "alb_target_port" {
  type        = number
  description = "ALB target port"
}

variable "alb_target_protocol" {
  type        = string
  description = "ALB target protocol"
}

variable "alb_health_check_path" {
  type        = string
  description = "ALB health check path"
}

variable "alb_ssl_policy" {
  type        = string
  description = "ALB SSL policy"
}

variable "alb_additional_certificate_arns" {
  type        = list(string)
  description = "ALB additional certificate ARNs"
  default     = []
}

# CloudWatch
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

# ECR
variable "ecr_repository_name" {
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

# ECS Task IAM Role
variable "iam_role_ecs_name" {
  type        = string
  description = "ECS task IAM role name"
}

variable "iam_role_ecs_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "ECS task IAM role assume role principals"
}

variable "iam_role_ecs_description" {
  type        = string
  description = "ECS task IAM role description"
}

variable "iam_role_ecs_path" {
  type        = string
  description = "ECS task IAM role path"
}

variable "iam_role_ecs_max_session_duration" {
  type        = number
  description = "ECS task IAM role max session duration"
}

variable "iam_role_ecs_managed_policy_arns" {
  type        = list(string)
  description = "ECS task IAM role managed policy ARNs"
}

variable "iam_role_ecs_inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "ECS task IAM role inline policies"
  default     = {}
}

variable "iam_role_ecs_permissions_boundary" {
  type        = string
  description = "ECS task IAM role permissions boundary"
  default     = null
}

variable "iam_role_ecs_force_detach_policies" {
  type        = bool
  description = "ECS task IAM role force detach policies"
}

# Lambda IAM Role
variable "iam_role_lambda_name" {
  type        = string
  description = "Lambda IAM role name"
}

variable "iam_role_lambda_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Lambda IAM role assume role principals"
}

variable "iam_role_lambda_description" {
  type        = string
  description = "Lambda IAM role description"
}

variable "iam_role_lambda_path" {
  type        = string
  description = "Lambda IAM role path"
}

variable "iam_role_lambda_max_session_duration" {
  type        = number
  description = "Lambda IAM role max session duration"
}

variable "iam_role_lambda_managed_policy_arns" {
  type        = list(string)
  description = "Lambda IAM role managed policy ARNs"
}

variable "iam_role_lambda_inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "Lambda IAM role inline policies"
  default     = {}
}

variable "iam_role_lambda_permissions_boundary" {
  type        = string
  description = "Lambda IAM role permissions boundary"
  default     = null
}

variable "iam_role_lambda_force_detach_policies" {
  type        = bool
  description = "Lambda IAM role force detach policies"
}

# ECS Fargate
variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "ecs_service_name" {
  type        = string
  description = "ECS service name"
}

variable "ecs_task_family" {
  type        = string
  description = "ECS task family"
}

variable "ecs_container_name" {
  type        = string
  description = "ECS container name"
}

variable "ecs_container_image" {
  type        = string
  # Placeholder — replaced by CI/CD pipeline after first image push
  description = "ECS container image URI"
}

variable "ecs_cpu" {
  type        = number
  description = "ECS task CPU units"
}

variable "ecs_memory" {
  type        = number
  description = "ECS task memory MB"
}

variable "ecs_container_port" {
  type        = number
  description = "ECS container port"
}

variable "ecs_desired_count" {
  type        = number
  description = "ECS desired count"
}

variable "ecs_assign_public_ip" {
  type        = bool
  description = "ECS assign public IP"
}

variable "ecs_enable_autoscaling" {
  type        = bool
  description = "ECS enable autoscaling"
}

variable "ecs_autoscaling_min" {
  type        = number
  description = "ECS autoscaling min"
}

variable "ecs_autoscaling_max" {
  type        = number
  description = "ECS autoscaling max"
}

variable "ecs_autoscaling_cpu_target" {
  type        = number
  description = "ECS autoscaling CPU target"
}

variable "ecs_log_retention_days" {
  type        = number
  description = "ECS log retention days"
}

variable "ecs_task_role_arn" {
  type        = string
  description = "ECS task role ARN"
  default     = null
}

# Lambda Function
variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_description" {
  type        = string
  description = "Lambda function description"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime"
  default     = null
}

variable "lambda_handler" {
  type        = string
  description = "Lambda handler"
  default     = null
}

variable "lambda_architecture" {
  type        = string
  description = "Lambda architecture"
}

variable "lambda_package_type" {
  type        = string
  description = "Lambda package type"
}

variable "lambda_image_uri" {
  type        = string
  # Placeholder — replaced by CI/CD pipeline after first image push
  description = "Lambda image URI"
  default     = null
}

variable "lambda_timeout" {
  type        = number
  description = "Lambda timeout"
}

variable "lambda_memory_size" {
  type        = number
  description = "Lambda memory size"
}

variable "lambda_reserved_concurrent_executions" {
  type        = number
  description = "Lambda reserved concurrent executions"
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

variable "lambda_layer_arns" {
  type        = list(string)
  description = "Lambda layer ARNs"
  default     = []
}

variable "lambda_create_cloudwatch_log_group" {
  type        = bool
  description = "Lambda create CloudWatch log group"
}

variable "lambda_log_retention_in_days" {
  type        = number
  description = "Lambda log retention in days"
}

variable "lambda_create_alias" {
  type        = bool
  description = "Lambda create alias"
}

variable "lambda_create_function_url" {
  type        = bool
  description = "Lambda create function URL"
}

variable "lambda_allowed_triggers" {
  type        = map(any)
  description = "Lambda allowed triggers"
  default     = {}
}

# Secrets Manager
variable "secrets_manager_name" {
  type        = string
  description = "Secrets Manager secret name"
}

variable "secrets_manager_recovery_window_in_days" {
  type        = number
  description = "Secrets Manager recovery window in days"
}

variable "secrets_manager_enable_rotation" {
  type        = bool
  description = "Secrets Manager enable rotation"
}

variable "secrets_manager_rotation_automatically_after_days" {
  type        = number
  description = "Secrets Manager rotation automatically after days"
}

variable "secrets_manager_block_public_policy" {
  type        = bool
  description = "Secrets Manager block public policy"
}
