variable "name" {
  description = "Name to assign to the NAT Gateway and associated resources."
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 128
    error_message = "The name must be between 1 and 128 characters."
  }
}

variable "subnet_id" {
  description = "The ID of the public subnet in which to place the NAT Gateway."
  type        = string

  validation {
    condition     = can(regex("^subnet-", var.subnet_id))
    error_message = "subnet_id must be a valid AWS subnet ID starting with 'subnet-'."
  }
}

variable "connectivity_type" {
  description = "Connectivity type for the NAT Gateway. Valid values are 'public' or 'private'."
  type        = string
  default     = "public"

  validation {
    condition     = contains(["public", "private"], var.connectivity_type)
    error_message = "connectivity_type must be either 'public' or 'private'."
  }
}

variable "create_eip" {
  description = "Whether to create a new Elastic IP address for the NAT Gateway. Set to false to use an existing EIP via existing_eip_allocation_id."
  type        = bool
  default     = true
}

variable "existing_eip_allocation_id" {
  description = "The allocation ID of an existing Elastic IP to associate with the NAT Gateway. Required when create_eip is false and connectivity_type is 'public'."
  type        = string
  default     = null

  validation {
    condition     = var.existing_eip_allocation_id == null || can(regex("^eipalloc-", var.existing_eip_allocation_id))
    error_message = "existing_eip_allocation_id must be a valid EIP allocation ID starting with 'eipalloc-', or null."
  }
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
