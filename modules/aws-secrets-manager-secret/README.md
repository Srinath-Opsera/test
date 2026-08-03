# Terraform Module: AWS Secrets Manager Secret

This module creates and manages an AWS Secrets Manager secret, including optional secret versioning, automatic rotation, and a resource-based policy.

## Usage

hcl
module "my_secret" {
  source = "./modules/secrets-manager"

  name                    = "my-app/database-credentials"
  description             = "Database credentials for my application"
  kms_key_id              = "arn:aws:kms:us-east-1:123456789012:key/mrk-abc123"
  recovery_window_in_days = 7

  secret_string = jsonencode({
    username = "admin"
    password = "supersecret"
  })

  enable_rotation                  = true
  rotation_lambda_arn              = "arn:aws:lambda:us-east-1:123456789012:function:my-rotation-fn"
  rotation_automatically_after_days = 30

  replica_regions = [
    {
      region     = "us-west-2"
      kms_key_id = "arn:aws:kms:us-west-2:123456789012:key/mrk-def456"
    }
  ]

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | The name of the secret | `string` | — | yes |
| `description` | A description of the secret | `string` | `null` | no |
| `kms_key_id` | ARN or ID of the KMS key used to encrypt the secret | `string` | `null` | no |
| `recovery_window_in_days` | Days before permanent deletion (0 or 7–30) | `number` | `30` | no |
| `force_overwrite_replica_secret` | Overwrite existing replica secret in destination region | `bool` | `false` | no |
| `replica_regions` | List of replica region configurations | `list(object)` | `[]` | no |
| `secret_string` | Plaintext secret value | `string` | `null` | no |
| `secret_binary` | Base64-encoded binary secret value | `string` | `null` | no |
| `version_stages` | Staging labels for the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable automatic secret rotation | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the rotation Lambda function | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between automatic rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource policy document | `string` | `null` | no |
| `block_public_policy` | Block public access via resource policy | `bool` | `true` | no |
| `tags` | Map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | The ID (ARN) of the secret |
| `secret_arn` | The ARN of the secret |
| `secret_name` | The name of the secret |
| `secret_version_id` | The version ID of the stored secret value |
| `rotation_enabled` | Whether automatic rotation is enabled |
| `replica_arns` | Map of replica region to last accessed date |

## Notes

- `secret_string` and `secret_binary` are mutually exclusive; only one should be set.
- Setting `recovery_window_in_days = 0` forces immediate deletion with no recovery window.
- `rotation_lambda_arn` is required when `enable_rotation = true`.
