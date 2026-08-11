variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "name" {
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
}

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
}

variable "alb_name" {
  type        = string
  description = "ALB name"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN"
}

variable "internal" {
  type        = bool
  description = "ALB internal flag"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "ALB deletion protection"
}

variable "idle_timeout" {
  type        = number
  description = "ALB idle timeout"
}

variable "target_port" {
  type        = number
  description = "ALB target port"
}

variable "target_protocol" {
  type        = string
  description = "ALB target protocol"
}

variable "health_check_path" {
  type        = string
  description = "ALB health check path"
}

variable "ssl_policy" {
  type        = string
  description = "ALB SSL policy"
}

variable "additional_certificate_arns" {
  type        = list(string)
  description = "ALB additional certificate ARNs"
}

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
}

variable "dashboards" {
  type = map(object({
    dashboard_name = string
    dashboard_body = string
  }))
  description = "CloudWatch dashboards"
}

variable "log_streams" {
  type = map(object({
    name           = string
    log_group_name = string
  }))
  description = "CloudWatch log streams"
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
}

variable "event_targets" {
  type = map(object({
    rule      = string
    target_id = string
    arn       = string
    role_arn  = optional(string, null)
  }))
  description = "CloudWatch event targets"
}

variable "iam_role_name" {
  type        = string
  description = "IAM role name"
}

variable "assume_role_principals" {
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

variable "path" {
  type        = string
  description = "IAM role path"
}

variable "max_session_duration" {
  type        = number
  description = "IAM role max session duration"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "IAM role managed policy ARNs"
}

variable "inline_policies" {
  type = map(object({
    name   = string
    policy = string
  }))
  description = "IAM role inline policies"
}

variable "permissions_boundary" {
  type        = string
  description = "IAM role permissions boundary"
  default     = null
}

variable "force_detach_policies" {
  type        = bool
  description = "IAM role force detach policies"
}

variable "cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "service_name" {
  type        = string
  description = "ECS service name"
}

variable "task_family" {
  type        = string
  description = "ECS task family"
}

variable "container_name" {
  type        = string
  description = "ECS container name"
}

variable "container_image" {
  type        = string
  description = "ECS container image URI"
}

variable "cpu" {
  type        = number
  description = "ECS task CPU units"
}

variable "memory" {
  type        = number
  description = "ECS task memory MB"
}

variable "container_port" {
  type        = number
  description = "ECS container port"
}

variable "desired_count" {
  type        = number
  description = "ECS desired task count"
}

variable "assign_public_ip" {
  type        = bool
  description = "ECS assign public IP"
}

variable "enable_autoscaling" {
  type        = bool
  description = "ECS enable autoscaling"
}

variable "autoscaling_min" {
  type        = number
  description = "ECS autoscaling min"
}

variable "autoscaling_max" {
  type        = number
  description = "ECS autoscaling max"
}

variable "autoscaling_cpu_target" {
  type        = number
  description = "ECS autoscaling CPU target"
}

variable "log_retention_days" {
  type        = number
  description = "ECS log retention days"
}

variable "task_role_arn" {
  type        = string
  description = "ECS task role ARN"
  default     = null
}

variable "team" {
  type        = string
  description = "Team or group name for resource tagging"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. dev, staging, prod)"
}
