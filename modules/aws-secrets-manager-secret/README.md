# Terraform Module: AWS Secrets Manager Secret

This module creates and manages an AWS Secrets Manager secret, including optional secret version storage, automatic rotation, and a resource-based policy.

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
    password = "s3cr3t"
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
| `force_overwrite_replica_secret` | Overwrite replica secret with same name in destination region | `bool` | `false` | no |
| `replica_regions` | List of replica region configurations (`region`, optional `kms_key_id`) | `list(object)` | `[]` | no |
| `secret_string` | Plaintext secret value (sensitive) | `string` | `null` | no |
| `secret_binary` | Base64-encoded binary secret value (sensitive) | `string` | `null` | no |
| `version_stages` | Staging labels for the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable automatic rotation | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the Lambda rotation function (required if `enable_rotation = true`) | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between automatic rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource-based policy document | `string` | `null` | no |
| `block_public_policy` | Block broad public access via resource policy | `bool` | `true` | no |
| `tags` | Map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | The ID (ARN) of the secret |
| `secret_arn` | The ARN of the secret |
| `secret_name` | The name of the secret |
| `secret_version_id` | The version ID of the stored secret value |
| `rotation_enabled` | Whether automatic rotation is enabled (true when the rotation resource is provisioned) |
| `kms_key_id` | The KMS key ID used for encryption |

## Notes

- Only one of `secret_string` or `secret_binary` should be provided at a time.
- Setting `recovery_window_in_days = 0` forces immediate deletion with no recovery window.
- `rotation_lambda_arn` is required when `enable_rotation = true`.
- `rotation_enabled` reflects whether the `aws_secretsmanager_secret_rotation` resource was provisioned, not a native attribute of the secret resource.
