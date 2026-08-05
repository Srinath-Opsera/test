# Terraform Module: Secrets Manager Secret

Manages an AWS Secrets Manager secret, including optional secret value versioning, automatic rotation, and resource-based policy attachment.

## Usage


module "db_password" {
  source = "./modules/secrets-manager"

  name        = "prod/myapp/db-password"
  description = "RDS master password for myapp production"
  kms_key_id  = "arn:aws:kms:us-east-1:123456789012:key/mrk-abc123"

  secret_string = jsonencode({
    username = "admin"
    password = "s3cr3t!"
  })

  recovery_window_in_days = 7

  enable_rotation                  = true
  rotation_lambda_arn              = "arn:aws:lambda:us-east-1:123456789012:function:rotate-secret"
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
| `description` | Human-readable description | `string` | `null` | no |
| `kms_key_id` | KMS key ARN/ID for encryption | `string` | `null` | no |
| `recovery_window_in_days` | Days before permanent deletion (0 or 7–30) | `number` | `30` | no |
| `force_overwrite_replica_secret` | Overwrite replica secret on conflict | `bool` | `false` | no |
| `replica_regions` | List of replica region objects (`region`, optional `kms_key_id`) | `list(object)` | `[]` | no |
| `secret_string` | Plaintext secret value (sensitive) | `string` | `null` | no |
| `secret_binary` | Base64-encoded binary secret value (sensitive) | `string` | `null` | no |
| `version_stages` | Staging labels for the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable Lambda-based automatic rotation | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the rotation Lambda (required if `enable_rotation = true`) | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between automatic rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource policy document | `string` | `null` | no |
| `block_public_policy` | Block broad public resource policies | `bool` | `true` | no |
| `tags` | Map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | ID of the secret |
| `secret_arn` | ARN of the secret |
| `secret_name` | Name of the secret |
| `secret_version_id` | Version ID of the stored secret value |
| `rotation_enabled` | Whether rotation is currently enabled |
| `replica_arns` | Map of replica region to last-accessed date |

## Notes

- Only one of `secret_string` or `secret_binary` should be provided at a time.
- Setting `recovery_window_in_days = 0` forces immediate deletion with no recovery window — use with caution.
- The `rotation_lambda_arn` must have a resource-based policy granting Secrets Manager permission to invoke it.
