# AWS Internet Gateway Module

Provisions an AWS Internet Gateway and attaches it to an existing VPC.

## Usage


module "igw" {
  source = "./modules/internet-gateway"

  name   = "my-igw"
  vpc_id = "vpc-0abc123def456789a"

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name to assign to the Internet Gateway resource. | `string` | — | yes |
| `vpc_id` | The ID of the VPC to which the Internet Gateway will be attached. | `string` | — | yes |
| `tags` | A map of tags to assign to the Internet Gateway resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Internet Gateway. |
| `arn` | The ARN of the Internet Gateway. |
| `vpc_id` | The ID of the VPC to which the Internet Gateway is attached. |
| `name` | The name assigned to the Internet Gateway. |
| `tags_all` | A map of all tags assigned to the Internet Gateway. |

## Notes

- Only one Internet Gateway can be attached to a VPC at a time. Ensure the target VPC does not already have an Internet Gateway attached before applying this module.
- The `vpc_id` input is validated to match the `vpc-xxxxxxxxx` format.
