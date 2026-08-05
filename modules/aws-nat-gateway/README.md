# NAT Gateway Module

This Terraform module creates one or more AWS NAT Gateways, optionally provisioning Elastic IP addresses for public gateways.

## Usage

### Single Public NAT Gateway (new EIP)


module "nat_gateway" {
  source = "./modules/nat-gateway"

  name             = "my-app-prod"
  subnet_ids       = ["subnet-0abc123"]
  nat_gateway_count = 1
  connectivity_type = "public"
  create_eip       = true

  tags = {
    Environment = "prod"
    Team        = "platform"
  }
}


### Multiple Public NAT Gateways (one per AZ)


module "nat_gateway" {
  source = "./modules/nat-gateway"

  name              = "my-app-prod"
  subnet_ids        = ["subnet-0abc123", "subnet-0def456", "subnet-0ghi789"]
  nat_gateway_count = 3
  connectivity_type = "public"
  create_eip        = true

  tags = {
    Environment = "prod"
  }
}


### Public NAT Gateway with existing EIPs


module "nat_gateway" {
  source = "./modules/nat-gateway"

  name               = "my-app-prod"
  subnet_ids         = ["subnet-0abc123"]
  nat_gateway_count  = 1
  connectivity_type  = "public"
  create_eip         = false
  eip_allocation_ids = ["eipalloc-0abc123"]

  tags = {
    Environment = "prod"
  }
}


### Private NAT Gateway


module "nat_gateway" {
  source = "./modules/nat-gateway"

  name              = "my-app-prod"
  subnet_ids        = ["subnet-0abc123"]
  nat_gateway_count = 1
  connectivity_type = "private"

  tags = {
    Environment = "prod"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Base name for NAT Gateway and associated resources | `string` | — | yes |
| subnet_ids | List of subnet IDs in which to create NAT Gateways | `list(string)` | — | yes |
| nat_gateway_count | Number of NAT Gateways to create | `number` | `1` | no |
| connectivity_type | Connectivity type: `public` or `private` | `string` | `"public"` | no |
| create_eip | Whether to create new Elastic IPs | `bool` | `true` | no |
| eip_allocation_ids | Existing EIP allocation IDs (when create_eip is false) | `list(string)` | `[]` | no |
| tags | Map of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| nat_gateway_ids | List of NAT Gateway IDs |
| nat_gateway_public_ips | List of public IPs associated with the NAT Gateways |
| nat_gateway_private_ips | List of private IPs associated with the NAT Gateways |
| eip_ids | List of Elastic IP IDs created by this module |
| eip_public_ips | List of Elastic IP public addresses created by this module |
| nat_gateway_subnet_ids | List of subnet IDs in which NAT Gateways were created |

## Notes

- `nat_gateway_count` must not exceed the number of entries in `subnet_ids`.
- When `connectivity_type` is `private`, EIPs are not created or required.
- When `create_eip` is `false` and `connectivity_type` is `public`, you must supply `eip_allocation_ids` with a count matching `nat_gateway_count`.
- Route table associations are **not** managed by this module; use the output `nat_gateway_ids` to configure routes in your root module or a routing module.
