variable "region" {
  type        = string
  description = "AWS region"
}

variable "service_name" {
  type        = string
  description = "Service name"
}

variable "team" {
  type        = string
  description = "Team name"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks"
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

variable "vpc_map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch for VPC public subnets"
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
  description = "Map public IP on launch for public subnet"
}

variable "public_subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation for public subnet"
}

variable "public_subnet_ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block for public subnet"
  default     = null
}

variable "public_subnet_create_route_table" {
  type        = bool
  description = "Create route table for public subnet"
}

variable "public_subnet_default_route_target_id" {
  type        = string
  description = "Default route target ID for public subnet"
  default     = null
}

variable "public_subnet_default_route_target_type" {
  type        = string
  description = "Default route target type for public subnet"
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
  description = "Additional routes for public subnet"
  default     = []
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
  description = "Map public IP on launch for private subnet"
}

variable "private_subnet_assign_ipv6_address_on_creation" {
  type        = bool
  description = "Assign IPv6 address on creation for private subnet"
}

variable "private_subnet_ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block for private subnet"
  default     = null
}

variable "private_subnet_create_route_table" {
  type        = bool
  description = "Create route table for private subnet"
}

variable "private_subnet_default_route_target_id" {
  type        = string
  description = "Default route target ID for private subnet"
  default     = null
}

variable "private_subnet_default_route_target_type" {
  type        = string
  description = "Default route target type for private subnet"
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
  description = "Additional routes for private subnet"
  default     = []
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "force_destroy" {
  type        = bool
  description = "Force destroy bucket"
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 versioning"
}

variable "sse_algorithm" {
  type        = string
  description = "SSE algorithm"
}

variable "kms_master_key_id" {
  type        = string
  description = "KMS master key ID"
  default     = null
}

variable "block_public_acls" {
  type        = bool
  description = "Block public ACLs"
}

variable "block_public_policy" {
  type        = bool
  description = "Block public policy"
}

variable "ignore_public_acls" {
  type        = bool
  description = "Ignore public ACLs"
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Restrict public buckets"
}

variable "lifecycle_rules" {
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

variable "bucket_policy_json" {
  type        = string
  description = "S3 bucket policy JSON"
  default     = null
}


variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}
