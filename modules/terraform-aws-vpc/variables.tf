variable "name" {
  type        = string
  description = "Base name prefix for VPC resources (e.g. project or environment name)."
}

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zone names to spread subnets across (e.g. [\"us-east-1a\", \"us-east-1b\"])."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets (one per AZ, same order as availability_zones)."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets (one per AZ, same order as availability_zones)."
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to create a NAT gateway for private subnet egress."
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "If true, use one NAT gateway shared across AZs; if false, one NAT per AZ."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC."
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC."
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Assign public IPv4 addresses to instances launched in public subnets."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to merge onto all resources."
  default     = {}
}
