variable "name" {
  type        = string
  description = "Name of the security group."
}

variable "description" {
  type        = string
  description = "Description of the security group."
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created."
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
  description = "Inbound rules for the security group."
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
  description = "Outbound rules for the security group (default allow-all if empty)."
  default     = []
}

variable "default_egress_allow_all" {
  type        = bool
  description = "If true and egress_rules is empty, add a default allow-all egress rule."
  default     = true
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = "Instruct Terraform to revoke all rules on delete."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for the security group."
  default     = {}
}
