variable "name" {
  type        = string
  description = "Name tag for the subnet and associated route table."
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the subnet will be created."
}

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the subnet."
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the subnet (e.g. us-east-1a)."
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether instances launched in this subnet receive a public IPv4 address."
  default     = false
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "Whether to assign an IPv6 address on interface creation (requires IPv6 CIDR on VPC)."
  default     = false
}

variable "ipv6_cidr_block" {
  type        = string
  description = "Optional IPv6 CIDR block for the subnet (leave empty to omit IPv6)."
  default     = null
}

variable "create_route_table" {
  type        = bool
  description = "Whether to create a dedicated route table and associate it with this subnet."
  default     = true
}

variable "route_table_id" {
  type        = string
  description = "Existing route table ID to associate (used when create_route_table is false)."
  default     = null
}

variable "default_route_target_id" {
  type        = string
  description = "Target for default route (IGW ID for public, NAT GW ID for private); set null to skip default route."
  default     = null
}

variable "default_route_target_type" {
  type        = string
  description = "Type of default route target: gateway_id, nat_gateway_id, or transit_gateway_id."
  default     = "gateway_id"
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
  description = "Additional static routes for the created route table."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to merge onto subnet and route table resources."
  default     = {}
}
