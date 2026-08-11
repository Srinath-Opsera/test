variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "log_groups" {
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  description = "Map of CloudWatch log groups"
  default     = {}
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
  description = "Map public IP on launch for VPC public subnets"
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
}

variable "description" {
  type        = string
  description = "Security group description"
}

variable "ingress_rules" {
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

variable "egress_rules" {
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

variable "default_egress_allow_all" {
  type        = bool
  description = "Default allow-all egress rule"
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "Revoke rules on delete"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "subnet_cidr_block" {
  type        = string
  description = "Subnet CIDR block"
}

variable "availability_zone" {
  type        = string
  description = "Subnet availability zone"
}

variable "map_public_ip_on_launch_subnet" {
  type        = bool
  description = "Map public IP on launch for subnet"
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation"
}

variable "ipv6_cidr_block" {
  type        = string
  description = "Subnet IPv6 CIDR block"
  default     = null
}

variable "create_route_table" {
  type        = bool
  description = "Create route table"
}

variable "route_table_id" {
  type        = string
  description = "Existing route table ID"
  default     = null
}

variable "default_route_target_id" {
  type        = string
  description = "Default route target ID"
  default     = null
}

variable "default_route_target_type" {
  type        = string
  description = "Default route target type"
}

variable "additional_routes" {
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))
  description = "Additional subnet routes"
  default     = []
}

variable "function_name" {
  type        = string
  description = "Lambda function name"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime"
}

variable "handler" {
  type        = string
  description = "Lambda handler"
}

variable "lambda_description" {
  type        = string
  description = "Lambda function description"
  default     = ""
}

variable "filename" {
  type        = string
  description = "Lambda deployment package path"
  default     = null
}

variable "source_code_hash" {
  type        = string
  description = "Lambda source code hash"
  default     = null
}

variable "memory_size" {
  type        = number
  description = "Lambda memory in MB"
}

variable "timeout" {
  type        = number
  description = "Lambda timeout in seconds"
}

variable "architectures" {
  type        = list(string)
  description = "Lambda architectures"
}

variable "environment_variables" {
  type        = map(string)
  description = "Lambda environment variables"
  default     = {}
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "Lambda reserved concurrency"
}

variable "log_retention_days" {
  type        = number
  description = "Lambda log retention in days"
}

variable "additional_policy_arns" {
  type        = list(string)
  description = "Additional IAM policy ARNs for Lambda"
  default     = []
}
