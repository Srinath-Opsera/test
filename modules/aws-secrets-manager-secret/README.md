# Terraform Module: Secrets Manager Secret

Creates and manages an AWS Secrets Manager secret with optional versioning, rotation, replication, and resource policy.

## Usage


module "db_password" {
  source = "./modules/secretsmanager"

  name        = "prod/myapp/db-password"
  description = "RDS master password for myapp production"
  kms_key_id  = "arn:aws:kms:us-east-1:123456789012:key/mrk-abc123"

  secret_string = "supersecretpassword"

  recovery_window_in_days = 7

  enable_rotation                   = true
  rotation_lambda_arn               = "arn:aws:lambda:us-east-1:123456789012:function:SecretsManagerRotation"
  rotation_automatically_after_days = 30

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


### JSON Secret Example


module "api_credentials" {
  source = "./modules/secretsmanager"

  name           = "prod/myapp/api-credentials"
  secret_is_json = true
  secret_string_json = {
    username = "api_user"
    password = "s3cr3t"
    host     = "db.example.com"
  }

  tags = {
    Environment = "production"
  }
}


### Multi-Region Replication Example


module "replicated_secret" {
  source = "./modules/secretsmanager"

  name          = "prod/myapp/shared-key"
  secret_string = "my-shared-key"

  replica_regions = [
    { region = "us-west-2" },
    { region = "eu-west-1", kms_key_id = "arn:aws:kms:eu-west-1:123456789012:key/mrk-xyz" }
  ]

  tags = {
    Environment = "production"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | The name of the secret | `string` | — | yes |
| `description` | A description of the secret | `string` | `null` | no |
| `kms_key_id` | ARN or ID of the KMS key for encryption | `string` | `null` | no |
| `recovery_window_in_days` | Days before permanent deletion (0 or 7–30) | `number` | `30` | no |
| `force_overwrite_replica_secret` | Overwrite existing replica secrets | `bool` | `false` | no |
| `replica_regions` | List of replica region configurations | `list(object)` | `[]` | no |
| `secret_string` | Plain text secret value | `string` | `null` | no |
| `secret_is_json` | JSON-encode `secret_string_json` as the secret value | `bool` | `false` | no |
| `secret_string_json` | Map to JSON-encode as the secret value | `map(string)` | `{}` | no |
| `secret_binary` | Base64-encoded binary secret value | `string` | `null` | no |
| `version_stages` | Staging labels for the secret version | `list(string)` | `null` | no |
| `enable_rotation` | Enable automatic rotation | `bool` | `false` | no |
| `rotation_lambda_arn` | ARN of the rotation Lambda function | `string` | `null` | no |
| `rotation_automatically_after_days` | Days between rotations (1–365) | `number` | `30` | no |
| `secret_policy` | JSON resource policy document | `string` | `null` | no |
| `block_public_policy` | Block broad resource-based policies | `bool` | `true` | no |
| `tags` | Map of tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `secret_id` | The ID (ARN) of the secret |
| `secret_arn` | The ARN of the secret |
| `secret_name` | The name of the secret |
| `secret_version_id` | The version ID of the initial secret value |
| `rotation_enabled` | Whether automatic rotation is enabled |
| `replica_arns` | ARNs of replica secrets in other regions |

## Notes

- **Initial secret value**: The `secret_string` / `secret_binary` is written once and then ignored on subsequent `terraform apply` runs to avoid overwriting values managed outside Terraform (e.g., by rotation).
- **Force delete**: Set `recovery_window_in_days = 0` to delete the secret immediately without a recovery window.
- **JSON secrets**: Set `secret_is_json = true` and populate `secret_string_json` to have Terraform JSON-encode the map automatically.
- **Rotation status**: The `rotation_enabled` output reflects whether an `aws_secretsmanager_secret_rotation` resource was created by this module. The `rotation_enabled` attribute was removed from `aws_secretsmanager_secret` in AWS provider v4+.
