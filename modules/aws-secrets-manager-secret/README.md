# Terraform Module: AWS Secrets Manager Secret

This module creates and manages an AWS Secrets Manager secret, including optional secret version storage, automatic rotation, and resource-based policy attachment.

## Usage


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

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | The name of the secret (1–512 characters) | `string` | — | yes |
| `description` | A description of the secret | `string` | `null` | no |
| `kms_key_id` | ARN or ID of the KMS key used to encrypt the secret | `string` | `null` | no |
| `recovery_window_in_days` | Days before permanent deletion (0 or 7–30) | `number` | `30` | no |
| `force_overwrite_replica_secret` | Overwrite existing replica secret in destination region | `bool` | `false` | no |
| `replica_regions` | List of replica region objects (`region`, optional `kms_key_id`) | `list(object)` | `[]` | no |
| `secret_string` | Plaintext secret value (sensitive) | `string` | `null` | no |
| `secret_binary` | Base64-encoded binary secret value (sensitive) | `string` | `null` | no |
| `version_stages` | Staging labels for the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable automatic rotation via Lambda | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the rotation Lambda (required if `enable_rotation = true`) | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between automatic rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource-based policy document | `string` | `null` | no |
| `block_public_policy` | Block broad resource-based policies | `bool` | `true` | no |
| `tags` | Map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | The ID of the secret (same as ARN) |
| `secret_arn` | The ARN of the secret |
| `secret_name` | The name of the secret |
| `secret_version_id` | The version ID of the stored secret value |
| `rotation_enabled` | Whether automatic rotation is enabled |
| `kms_key_id` | The KMS key ID used for encryption |
| `replica_regions` | Replica region configuration |

## Notes

- Only one of `secret_string` or `secret_binary` should be provided at a time.
- Setting `recovery_window_in_days = 0` forces immediate deletion with no recovery window.
- `rotation_lambda_arn` is required when `enable_rotation = true`.
- The root module is responsible for pinning the AWS provider version.
