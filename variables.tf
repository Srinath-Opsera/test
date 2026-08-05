variable "region" {
  type        = string
  description = "AWS region"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# VPC
variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
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

# Internet Gateway
variable "igw_name" {
  type        = string
  description = "Internet gateway name"
}

# NAT Gateway
variable "nat_name" {
  type        = string
  description = "NAT gateway name"
}

variable "nat_gateway_count" {
  type        = number
  description = "NAT gateway count"
}

variable "nat_connectivity_type" {
  type        = string
  description = "NAT gateway connectivity type"
}

variable "nat_create_eip" {
  type        = bool
  description = "NAT gateway create EIP"
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

variable "public_subnet_create_route_table" {
  type        = bool
  description = "Public subnet create route table"
}

variable "public_subnet_default_route_target_type" {
  type        = string
  description = "Public subnet default route target type"
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

variable "private_subnet_create_route_table" {
  type        = bool
  description = "Private subnet create route table"
}

variable "private_subnet_default_route_target_type" {
  type        = string
  description = "Private subnet default route target type"
}

# ALB Security Group
variable "alb_sg_name" {
  type        = string
  description = "ALB security group name"
}

variable "alb_sg_description" {
  type        = string
  description = "ALB security group description"
}

variable "alb_sg_ingress_rules" {
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

variable "alb_sg_egress_rules" {
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

variable "alb_sg_default_egress_allow_all" {
  type        = bool
  description = "ALB security group default egress allow all"
}

variable "alb_sg_revoke_rules_on_delete" {
  type        = bool
  description = "ALB security group revoke rules on delete"
}

# ECS Security Group
variable "ecs_sg_name" {
  type        = string
  description = "ECS security group name"
}

variable "ecs_sg_description" {
  type        = string
  description = "ECS security group description"
}

variable "ecs_sg_ingress_rules" {
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

variable "ecs_sg_egress_rules" {
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

variable "ecs_sg_default_egress_allow_all" {
  type        = bool
  description = "ECS security group default egress allow all"
}

variable "ecs_sg_revoke_rules_on_delete" {
  type        = bool
  description = "ECS security group revoke rules on delete"
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
  description = "ALB internal flag"
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

variable "ecr_force_delete" {
  type        = bool
  description = "ECR force delete"
}

# ECS Task Execution IAM Role
variable "ecs_exec_role_name" {
  type        = string
  description = "ECS task execution IAM role name"
}

variable "ecs_exec_role_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "ECS task execution IAM role assume role principals"
}

variable "ecs_exec_role_description" {
  type        = string
  description = "ECS task execution IAM role description"
}

variable "ecs_exec_role_path" {
  type        = string
  description = "ECS task execution IAM role path"
}

variable "ecs_exec_role_max_session_duration" {
  type        = number
  description = "ECS task execution IAM role max session duration"
}

variable "ecs_exec_role_managed_policy_arns" {
  type        = list(string)
  description = "ECS task execution IAM role managed policy ARNs"
}

variable "ecs_exec_role_inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "ECS task execution IAM role inline policies"
  default     = {}
}

variable "ecs_exec_role_force_detach_policies" {
  type        = bool
  description = "ECS task execution IAM role force detach policies"
}

# ECS Task IAM Role
variable "ecs_task_role_name" {
  type        = string
  description = "ECS task IAM role name"
}

variable "ecs_task_role_assume_role_principals" {
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  description = "ECS task IAM role assume role principals"
}

variable "ecs_task_role_description" {
  type        = string
  description = "ECS task IAM role description"
}

variable "ecs_task_role_path" {
  type        = string
  description = "ECS task IAM role path"
}

variable "ecs_task_role_max_session_duration" {
  type        = number
  description = "ECS task IAM role max session duration"
}

variable "ecs_task_role_managed_policy_arns" {
  type        = list(string)
  description = "ECS task IAM role managed policy ARNs"
}

variable "ecs_task_role_inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "ECS task IAM role inline policies"
  default     = {}
}

variable "ecs_task_role_force_detach_policies" {
  type        = bool
  description = "ECS task IAM role force detach policies"
}

# ECS Cluster / Fargate
variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "ecs_cluster_service_name" {
  type        = string
  description = "ECS cluster service name"
}

variable "ecs_cluster_task_family" {
  type        = string
  description = "ECS cluster task family"
}

variable "ecs_cluster_container_name" {
  type        = string
  description = "ECS cluster container name"
}

variable "container_image" {
  type        = string
  description = "Container image URI"
  # Placeholder — replaced by CI/CD pipeline after first image push
}

variable "ecs_cluster_cpu" {
  type        = number
  description = "ECS cluster CPU units"
}

variable "ecs_cluster_memory" {
  type        = number
  description = "ECS cluster memory MB"
}

variable "ecs_cluster_container_port" {
  type        = number
  description = "ECS cluster container port"
}

variable "ecs_cluster_desired_count" {
  type        = number
  description = "ECS cluster desired count"
}

variable "ecs_cluster_assign_public_ip" {
  type        = bool
  description = "ECS cluster assign public IP"
}

variable "ecs_cluster_enable_autoscaling" {
  type        = bool
  description = "ECS cluster enable autoscaling"
}

variable "ecs_cluster_autoscaling_min" {
  type        = number
  description = "ECS cluster autoscaling min"
}

variable "ecs_cluster_autoscaling_max" {
  type        = number
  description = "ECS cluster autoscaling max"
}

variable "ecs_cluster_autoscaling_cpu_target" {
  type        = number
  description = "ECS cluster autoscaling CPU target"
}

variable "ecs_cluster_log_retention_days" {
  type        = number
  description = "ECS cluster log retention days"
}

# Auto Scaling Policy
variable "asg_policy_name" {
  type        = string
  description = "Auto scaling policy name"
}

variable "asg_policy_autoscaling_group_name" {
  type        = string
  description = "Auto scaling group name"
}

variable "asg_policy_type" {
  type        = string
  description = "Auto scaling policy type"
}

variable "asg_policy_cooldown" {
  type        = number
  description = "Auto scaling policy cooldown"
}

variable "asg_policy_target_tracking_configuration" {
  type        = any
  description = "Auto scaling policy target tracking configuration"
}
