# AWS Secrets Manager Terraform Module

This module creates and manages an AWS Secrets Manager secret, including optional secret versions, automatic rotation, and resource-based policies.

## Usage


module "secret" {
  source = "./modules/secrets-manager"

  name        = "my-app/database-credentials"
  description = "Database credentials for my application"
  kms_key_id  = "arn:aws:kms:us-east-1:123456789012:key/mrk-abc123"

  secret_key_value_pairs = {
    username = "admin"
    password = "supersecret"
  }

  recovery_window_in_days = 7

  enable_rotation                   = true
  rotation_lambda_arn               = "arn:aws:lambda:us-east-1:123456789012:function:my-rotation-fn"
  rotation_automatically_after_days = 30

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
| `recovery_window_in_days` | Days before permanent deletion (0 for immediate, 7–30 otherwise) | `number` | `30` | no |
| `replica_regions` | List of replica region objects (`region`, optional `kms_key_id`) | `list(object)` | `[]` | no |
| `secret_string` | Plain string value to store in the secret | `string` | `null` | no |
| `secret_key_value_pairs` | Map of key/value pairs stored as JSON (overrides `secret_string`) | `map(string)` | `null` | no |
| `secret_binary` | Base64-encoded binary value to store | `string` | `null` | no |
| `version_stages` | Staging labels to attach to the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable automatic rotation | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the Lambda rotation function (required if `enable_rotation = true`) | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between automatic rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource-based policy document | `string` | `null` | no |
| `block_public_policy` | Block broad resource-based policies | `bool` | `true` | no |
| `tags` | Map of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | The ID (ARN) of the secret |
| `secret_arn` | The ARN of the secret |
| `secret_name` | The name of the secret |
| `secret_version_id` | The version ID of the stored secret value |
| `rotation_enabled` | Whether automatic rotation is enabled (derived from `aws_secretsmanager_secret_rotation` resource) |
| `replica_arns` | Map of replica region to replica secret ARN |

## Notes

- Setting `recovery_window_in_days = 0` forces immediate deletion with no recovery window.
- When both `secret_key_value_pairs` and `secret_string` are provided, `secret_key_value_pairs` takes precedence and is JSON-encoded.
- A secret version is created whenever any of `secret_key_value_pairs`, `secret_string`, or `secret_binary` is set.
- `rotation_lambda_arn` is required when `enable_rotation = true`.
- The `rotation_enabled` output is derived from the presence of an `aws_secretsmanager_secret_rotation` resource. The `rotation_enabled` attribute was removed from `aws_secretsmanager_secret` in AWS provider v4+.
- The `replica_arns` output maps each replica region to its replica secret ARN.
