# Terraform Module: Secrets Manager Secret

Creates and manages an AWS Secrets Manager secret, including optional secret value versioning, automatic rotation, and resource-based policy attachment.

## Usage


module "db_password" {
  source = "./modules/secrets-manager"

  name        = "prod/myapp/db-password"
  description = "Production database password for myapp"
  kms_key_id  = "arn:aws:kms:us-east-1:123456789012:key/mrk-abc123"

  secret_string = jsonencode({
    username = "admin"
    password = "s3cr3t!"
  })

  recovery_window_in_days = 7

  enable_rotation                   = true
  rotation_lambda_arn               = "arn:aws:lambda:us-east-1:123456789012:function:rotate-secret"
  rotation_automatically_after_days = 30

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the secret (1–512 chars) | `string` | — | yes |
| `description` | Description of the secret | `string` | `null` | no |
| `kms_key_id` | KMS key ARN/ID for encryption | `string` | `null` | no |
| `recovery_window_in_days` | Days before permanent deletion (0 or 7–30) | `number` | `30` | no |
| `force_overwrite_replica_secret` | Overwrite replica secret on conflict | `bool` | `false` | no |
| `replica_regions` | List of replica region configs (`region`, optional `kms_key_id`) | `list(object)` | `[]` | no |
| `secret_string` | Secret value as a string (sensitive) | `string` | `null` | no |
| `secret_binary` | Secret value as base64-encoded binary (sensitive) | `string` | `null` | no |
| `version_stages` | Staging labels for the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable automatic rotation via Lambda | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the rotation Lambda (required if `enable_rotation = true`) | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between automatic rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource policy document | `string` | `null` | no |
| `block_public_policy` | Block broad public access policies | `bool` | `true` | no |
| `tags` | Map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | ID of the secret (same as ARN) |
| `secret_arn` | ARN of the secret |
| `secret_name` | Name of the secret |
| `secret_version_id` | Version ID of the stored secret value |
| `rotation_enabled` | Whether automatic rotation is enabled (derived from `aws_secretsmanager_secret_rotation` resource) |
| `kms_key_id` | KMS key ID used for encryption |
