variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__name" {
  type        = string
  description = "VPC name"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__single_nat_gateway" {
  type        = bool
  description = "Single NAT gateway"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__enable_dns_support" {
  type        = bool
  description = "Enable DNS support"
}

variable "terraform_aws_vpc__virtual_private_cloud_vpc__map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch"
}

variable "terraform_aws_subnet__public_subnet__name" {
  type        = string
  description = "Public subnet name"
}

variable "terraform_aws_subnet__public_subnet__cidr_block" {
  type        = string
  description = "Public subnet CIDR block"
}

variable "terraform_aws_subnet__public_subnet__availability_zone" {
  type        = string
  description = "Public subnet availability zone"
}

variable "terraform_aws_subnet__public_subnet__map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch"
}

variable "terraform_aws_subnet__public_subnet__assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation"
}

variable "terraform_aws_subnet__public_subnet__ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block"
  default     = null
}

variable "terraform_aws_subnet__public_subnet__create_route_table" {
  type        = bool
  description = "Create route table"
}

variable "terraform_aws_subnet__public_subnet__default_route_target_id" {
  type        = string
  description = "Default route target ID"
  default     = null
}

variable "terraform_aws_subnet__public_subnet__default_route_target_type" {
  type        = string
  description = "Default route target type"
}

variable "terraform_aws_subnet__public_subnet__additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Additional routes"
  default     = []
}

variable "terraform_aws_subnet__private_subnet__name" {
  type        = string
  description = "Private subnet name"
}

variable "terraform_aws_subnet__private_subnet__cidr_block" {
  type        = string
  description = "Private subnet CIDR block"
}

variable "terraform_aws_subnet__private_subnet__availability_zone" {
  type        = string
  description = "Private subnet availability zone"
}

variable "terraform_aws_subnet__private_subnet__map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch"
}

variable "terraform_aws_subnet__private_subnet__assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation"
}

variable "terraform_aws_subnet__private_subnet__ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block"
  default     = null
}

variable "terraform_aws_subnet__private_subnet__create_route_table" {
  type        = bool
  description = "Create route table"
}

variable "terraform_aws_subnet__private_subnet__default_route_target_id" {
  type        = string
  description = "Default route target ID"
  default     = null
}

variable "terraform_aws_subnet__private_subnet__default_route_target_type" {
  type        = string
  description = "Default route target type"
}

variable "terraform_aws_subnet__private_subnet__additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Additional routes"
  default     = []
}

variable "terraform_aws_security_group__alb_security_group__name" {
  type        = string
  description = "ALB security group name"
}

variable "terraform_aws_security_group__alb_security_group__description" {
  type        = string
  description = "ALB security group description"
}

variable "terraform_aws_security_group__alb_security_group__ingress_rules" {
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

variable "terraform_aws_security_group__alb_security_group__egress_rules" {
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
}

variable "terraform_aws_security_group__alb_security_group__default_egress_allow_all" {
  type        = bool
  description = "Default egress allow all"
}

variable "terraform_aws_security_group__alb_security_group__revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
}

variable "terraform_aws_security_group__ecs_security_group__name" {
  type        = string
  description = "ECS security group name"
}

variable "terraform_aws_security_group__ecs_security_group__description" {
  type        = string
  description = "ECS security group description"
}

variable "terraform_aws_security_group__ecs_security_group__ingress_rules" {
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

variable "terraform_aws_security_group__ecs_security_group__egress_rules" {
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
}

variable "terraform_aws_security_group__ecs_security_group__default_egress_allow_all" {
  type        = bool
  description = "Default egress allow all"
}

variable "terraform_aws_security_group__ecs_security_group__revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
}

variable "terraform_aws_security_group__lambda_security_group__name" {
  type        = string
  description = "Lambda security group name"
}

variable "terraform_aws_security_group__lambda_security_group__description" {
  type        = string
  description = "Lambda security group description"
}

variable "terraform_aws_security_group__lambda_security_group__ingress_rules" {
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
}

variable "terraform_aws_security_group__lambda_security_group__egress_rules" {
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
}

variable "terraform_aws_security_group__lambda_security_group__default_egress_allow_all" {
  type        = bool
  description = "Default egress allow all"
}

variable "terraform_aws_security_group__lambda_security_group__revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
}

variable "terraform_aws_security_group__rds_security_group__name" {
  type        = string
  description = "RDS security group name"
}

variable "terraform_aws_security_group__rds_security_group__description" {
  type        = string
  description = "RDS security group description"
}

variable "terraform_aws_security_group__rds_security_group__ingress_rules" {
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
  description = "RDS security group ingress rules"
}

variable "terraform_aws_security_group__rds_security_group__egress_rules" {
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
  description = "RDS security group egress rules"
}

variable "terraform_aws_security_group__rds_security_group__default_egress_allow_all" {
  type        = bool
  description = "Default egress allow all"
}

variable "terraform_aws_security_group__rds_security_group__revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
}

variable "terraform_aws_alb__application_load_balancer__name" {
  type        = string
  description = "ALB name"
}

variable "terraform_aws_alb__application_load_balancer__certificate_arn" {
  type        = string
  description = "ACM certificate ARN"
}

variable "terraform_aws_alb__application_load_balancer__internal" {
  type        = bool
  description = "Internal load balancer"
}

variable "terraform_aws_alb__application_load_balancer__enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection"
}

variable "terraform_aws_alb__application_load_balancer__idle_timeout" {
  type        = number
  description = "Idle timeout in seconds"
}

variable "terraform_aws_alb__application_load_balancer__target_port" {
  type        = number
  description = "Target port"
}

variable "terraform_aws_alb__application_load_balancer__target_protocol" {
  type        = string
  description = "Target protocol"
}

variable "terraform_aws_alb__application_load_balancer__health_check_path" {
  type        = string
  description = "Health check path"
}

variable "terraform_aws_alb__application_load_balancer__ssl_policy" {
  type        = string
  description = "SSL policy"
}

variable "terraform_aws_alb__application_load_balancer__additional_certificate_arns" {
  type        = list(string)
  description = "Additional certificate ARNs"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__name" {
  type        = string
  description = "ECS task IAM role name"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "ECS task IAM role assume role principals"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__description" {
  type        = string
  description = "ECS task IAM role description"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__path" {
  type        = string
  description = "ECS task IAM role path"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__max_session_duration" {
  type        = number
  description = "ECS task IAM role max session duration"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__managed_policy_arns" {
  type        = list(string)
  description = "ECS task IAM role managed policy ARNs"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "ECS task IAM role inline policies"
}

variable "terraform_aws_iam_role__ecs_task_iam_role__permissions_boundary" {
  type        = string
  description = "ECS task IAM role permissions boundary"
  default     = null
}

variable "terraform_aws_iam_role__ecs_task_iam_role__force_detach_policies" {
  type        = bool
  description = "ECS task IAM role force detach policies"
}

variable "terraform_aws_iam_role__lambda_iam_role__name" {
  type        = string
  description = "Lambda IAM role name"
}

variable "terraform_aws_iam_role__lambda_iam_role__assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "Lambda IAM role assume role principals"
}

variable "terraform_aws_iam_role__lambda_iam_role__description" {
  type        = string
  description = "Lambda IAM role description"
}

variable "terraform_aws_iam_role__lambda_iam_role__path" {
  type        = string
  description = "Lambda IAM role path"
}

variable "terraform_aws_iam_role__lambda_iam_role__max_session_duration" {
  type        = number
  description = "Lambda IAM role max session duration"
}

variable "terraform_aws_iam_role__lambda_iam_role__managed_policy_arns" {
  type        = list(string)
  description = "Lambda IAM role managed policy ARNs"
}

variable "terraform_aws_iam_role__lambda_iam_role__inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "Lambda IAM role inline policies"
}

variable "terraform_aws_iam_role__lambda_iam_role__permissions_boundary" {
  type        = string
  description = "Lambda IAM role permissions boundary"
  default     = null
}

variable "terraform_aws_iam_role__lambda_iam_role__force_detach_policies" {
  type        = bool
  description = "Lambda IAM role force detach policies"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__service_name" {
  type        = string
  description = "ECS service name"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__task_family" {
  type        = string
  description = "ECS task family"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__container_name" {
  type        = string
  description = "ECS container name"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__container_image" {
  type        = string
  description = "ECS container image"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__cpu" {
  type        = number
  description = "ECS task CPU units"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__memory" {
  type        = number
  description = "ECS task memory MB"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__container_port" {
  type        = number
  description = "ECS container port"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__desired_count" {
  type        = number
  description = "ECS desired task count"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__assign_public_ip" {
  type        = bool
  description = "ECS assign public IP"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__enable_autoscaling" {
  type        = bool
  description = "ECS enable autoscaling"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__autoscaling_min" {
  type        = number
  description = "ECS autoscaling min"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__autoscaling_max" {
  type        = number
  description = "ECS autoscaling max"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__autoscaling_cpu_target" {
  type        = number
  description = "ECS autoscaling CPU target"
}

variable "terraform_aws_ecs_fargate__ecs_cluster__log_retention_days" {
  type        = number
  description = "ECS log retention days"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__cluster_name" {
  type        = string
  description = "ECS Fargate cluster name"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__service_name" {
  type        = string
  description = "ECS Fargate service name"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__task_family" {
  type        = string
  description = "ECS Fargate task family"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__container_name" {
  type        = string
  description = "ECS Fargate container name"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__container_image" {
  type        = string
  description = "ECS Fargate container image"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__cpu" {
  type        = number
  description = "ECS Fargate task CPU units"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__memory" {
  type        = number
  description = "ECS Fargate task memory MB"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__container_port" {
  type        = number
  description = "ECS Fargate container port"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__desired_count" {
  type        = number
  description = "ECS Fargate desired task count"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__assign_public_ip" {
  type        = bool
  description = "ECS Fargate assign public IP"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__enable_autoscaling" {
  type        = bool
  description = "ECS Fargate enable autoscaling"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_min" {
  type        = number
  description = "ECS Fargate autoscaling min"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_max" {
  type        = number
  description = "ECS Fargate autoscaling max"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_cpu_target" {
  type        = number
  description = "ECS Fargate autoscaling CPU target"
}

variable "terraform_aws_ecs_fargate__ecs_fargate_service__log_retention_days" {
  type        = number
  description = "ECS Fargate log retention days"
}

variable "terraform_aws_rds__rds_aurora_postgresql__identifier" {
  type        = string
  description = "RDS instance identifier"
}

variable "terraform_aws_rds__rds_aurora_postgresql__engine" {
  type        = string
  description = "RDS engine"
}

variable "terraform_aws_rds__rds_aurora_postgresql__engine_version" {
  type        = string
  description = "RDS engine version"
}

variable "terraform_aws_rds__rds_aurora_postgresql__username" {
  type        = string
  description = "RDS master username"
}

variable "terraform_aws_rds__rds_aurora_postgresql__password" {
  type        = string
  description = "RDS master password"
  sensitive   = true
}

variable "terraform_aws_rds__rds_aurora_postgresql__db_subnet_group_name" {
  type        = string
  description = "RDS DB subnet group name"
}

variable "terraform_aws_rds__rds_aurora_postgresql__instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "terraform_aws_rds__rds_aurora_postgresql__allocated_storage" {
  type        = number
  description = "RDS allocated storage GB"
}

variable "terraform_aws_rds__rds_aurora_postgresql__max_allocated_storage" {
  type        = number
  description = "RDS max allocated storage GB"
}

variable "terraform_aws_rds__rds_aurora_postgresql__storage_type" {
  type        = string
  description = "RDS storage type"
}

variable "terraform_aws_rds__rds_aurora_postgresql__storage_encrypted" {
  type        = bool
  description = "RDS storage encrypted"
}

variable "terraform_aws_rds__rds_aurora_postgresql__kms_key_id" {
  type        = string
  description = "RDS KMS key ID"
  default     = null
}

variable "terraform_aws_rds__rds_aurora_postgresql__db_name" {
  type        = string
  description = "RDS database name"
}

variable "terraform_aws_rds__rds_aurora_postgresql__multi_az" {
  type        = bool
  description = "RDS multi AZ"
}

variable "terraform_aws_rds__rds_aurora_postgresql__backup_retention_period" {
  type        = number
  description = "RDS backup retention period"
}

variable "terraform_aws_rds__rds_aurora_postgresql__deletion_protection" {
  type        = bool
  description = "RDS deletion protection"
}

variable "terraform_aws_rds__rds_aurora_postgresql__skip_final_snapshot" {
  type        = bool
  description = "RDS skip final snapshot"
}

variable "terraform_aws_s3__s3_bucket__bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "terraform_aws_s3__s3_bucket__force_destroy" {
  type        = bool
  description = "S3 force destroy"
}

variable "terraform_aws_s3__s3_bucket__versioning_enabled" {
  type        = bool
  description = "S3 versioning enabled"
}

variable "terraform_aws_s3__s3_bucket__sse_algorithm" {
  type        = string
  description = "S3 SSE algorithm"
}

variable "terraform_aws_s3__s3_bucket__kms_master_key_id" {
  type        = string
  description = "S3 KMS master key ID"
  default     = null
}

variable "terraform_aws_s3__s3_bucket__block_public_acls" {
  type        = bool
  description = "S3 block public ACLs"
}

variable "terraform_aws_s3__s3_bucket__block_public_policy" {
  type        = bool
  description = "S3 block public policy"
}

variable "terraform_aws_s3__s3_bucket__ignore_public_acls" {
  type        = bool
  description = "S3 ignore public ACLs"
}

variable "terraform_aws_s3__s3_bucket__restrict_public_buckets" {
  type        = bool
  description = "S3 restrict public buckets"
}

variable "terraform_aws_s3__s3_bucket__lifecycle_rules" {
  type = list(object({
    id                                 = string
    status                             = optional(string, "Enabled")
    prefix                             = optional(string, "")
    filter_tags                        = optional(map(string), {})
    expiration_days                    = optional(number)
    noncurrent_version_expiration_days = optional(number)
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
  }))
  description = "S3 lifecycle rules"
  default     = []
}

variable "terraform_aws_s3__s3_bucket__bucket_policy_json" {
  type        = string
  description = "S3 bucket policy JSON"
  default     = null
}

variable "aws_secrets_manager__name" {
  type        = string
  description = "Secrets Manager secret name"
}

variable "aws_secrets_manager__description" {
  type        = string
  description = "Secrets Manager secret description"
  default     = null
}

variable "aws_secrets_manager__kms_key_id" {
  type        = string
  description = "Secrets Manager KMS key ID"
  default     = null
}

variable "aws_secrets_manager__recovery_window_in_days" {
  type        = number
  description = "Secrets Manager recovery window in days"
}

variable "aws_secrets_manager__secret_string" {
  type        = string
  description = "Secrets Manager secret string"
  sensitive   = true
  default     = null
}

variable "aws_secrets_manager__secret_key_value_pairs" {
  type        = map(string)
  description = "Secrets Manager secret key value pairs"
  sensitive   = true
  default     = null
}

variable "aws_secrets_manager__secret_binary" {
  type        = string
  description = "Secrets Manager secret binary"
  sensitive   = true
  default     = null
}

variable "aws_secrets_manager__enable_rotation" {
  type        = bool
  description = "Secrets Manager enable rotation"
}

variable "aws_secrets_manager__rotation_lambda_arn" {
  type        = string
  description = "Secrets Manager rotation Lambda ARN"
  default     = null
}

variable "aws_secrets_manager__rotation_automatically_after_days" {
  type        = number
  description = "Secrets Manager rotation automatically after days"
}

variable "aws_secrets_manager__block_public_policy" {
  type        = bool
  description = "Secrets Manager block public policy"
}

variable "aws_cloudwatch__cloudwatch_alarms__log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "CloudWatch alarms log groups"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_alarms__metric_alarms" {
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

variable "aws_cloudwatch__cloudwatch_alarms__dashboards" {
  type = map(object({
    dashboard_name = string
    dashboard_body = string
  }))
  description = "CloudWatch alarms dashboards"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_alarms__log_streams" {
  type = map(object({
    name           = string
    log_group_name = string
  }))
  description = "CloudWatch alarms log streams"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_alarms__event_rules" {
  type = map(object({
    name                = string
    description         = optional(string, "")
    event_pattern       = optional(string, null)
    schedule_expression = optional(string, null)
    state               = optional(string, "ENABLED")
    tags                = optional(map(string), {})
  }))
  description = "CloudWatch alarms event rules"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_alarms__event_targets" {
  type = map(object({
    rule      = string
    target_id = string
    arn       = string
    role_arn  = optional(string, null)
  }))
  description = "CloudWatch alarms event targets"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_log_group__log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "CloudWatch log group log groups"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_log_group__metric_alarms" {
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
  description = "CloudWatch log group metric alarms"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_log_group__dashboards" {
  type = map(object({
    dashboard_name = string
    dashboard_body = string
  }))
  description = "CloudWatch log group dashboards"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_log_group__log_streams" {
  type = map(object({
    name           = string
    log_group_name = string
  }))
  description = "CloudWatch log group log streams"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_log_group__event_rules" {
  type = map(object({
    name                = string
    description         = optional(string, "")
    event_pattern       = optional(string, null)
    schedule_expression = optional(string, null)
    state               = optional(string, "ENABLED")
    tags                = optional(map(string), {})
  }))
  description = "CloudWatch log group event rules"
  default     = {}
}

variable "aws_cloudwatch__cloudwatch_log_group__event_targets" {
  type = map(object({
    rule      = string
    target_id = string
    arn       = string
    role_arn  = optional(string, null)
  }))
  description = "CloudWatch log group event targets"
  default     = {}
}

variable "service_name" {
  type        = string
  description = "Service name for resource tagging"
}

variable "team" {
  type        = string
  description = "Team or group name for resource tagging"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. dev, staging, prod)"
}
