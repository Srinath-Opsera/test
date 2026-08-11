# NAT Gateway Module

Provisions an AWS NAT Gateway with an optional Elastic IP address.

## Usage


module "nat_gateway" {
  source = "./modules/nat-gateway"

  name              = "my-nat-gateway"
  subnet_id         = "subnet-0abc123def456789"
  connectivity_type = "public"
  create_eip        = true

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


### Using an existing EIP


module "nat_gateway" {
  source = "./modules/nat-gateway"

  name                       = "my-nat-gateway"
  subnet_id                  = "subnet-0abc123def456789"
  connectivity_type          = "public"
  create_eip                 = false
  existing_eip_allocation_id = "eipalloc-0abc123def456789"

  tags = {
    Environment = "production"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name for the NAT Gateway and associated resources | `string` | — | yes |
| subnet_id | ID of the public subnet to place the NAT Gateway in | `string` | — | yes |
| connectivity_type | Connectivity type: `public` or `private` | `string` | `"public"` | no |
| create_eip | Whether to create a new Elastic IP | `bool` | `true` | no |
| existing_eip_allocation_id | Allocation ID of an existing EIP (used when `create_eip = false`) | `string` | `null` | no |
| tags | Map of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| nat_gateway_id | ID of the NAT Gateway |
| nat_gateway_public_ip | Public IP of the NAT Gateway |
| nat_gateway_private_ip | Private IP of the NAT Gateway |
| nat_gateway_subnet_id | Subnet ID of the NAT Gateway |
| nat_gateway_allocation_id | EIP allocation ID associated with the NAT Gateway |
| eip_id | ID of the created EIP (null if `create_eip = false`) |
| eip_public_ip | Public IP of the created EIP (null if `create_eip = false`) |
| eip_allocation_id | Allocation ID of the created EIP (null if `create_eip = false`) |

## Notes

- For `connectivity_type = "public"`, either `create_eip = true` or a valid `existing_eip_allocation_id` must be provided.
- For `connectivity_type = "private"`, no EIP is required; set `create_eip = false`.
- The NAT Gateway must be placed in a **public** subnet (one with an Internet Gateway route) for public connectivity.
