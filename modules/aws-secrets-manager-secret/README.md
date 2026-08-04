# Terraform Module: AWS Secrets Manager Secret

This module creates and manages an AWS Secrets Manager secret, including optional secret versions, automatic rotation, replica regions, and resource-based policies.

## Usage


module "secret" {
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

  secret_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::123456789012:role/my-app-role" }
        Action    = "secretsmanager:GetSecretValue"
        Resource  = "*"
      }
    ]
  })

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the secret | `string` | — | yes |
| description | A description of the secret | `string` | `null` | no |
| kms_key_id | ARN or ID of the KMS key used to encrypt the secret | `string` | `null` | no |
| recovery_window_in_days | Days before permanent deletion (0 for immediate, 7–30 otherwise) | `number` | `30` | no |
| force_overwrite_replica_secret | Overwrite existing replica secret with the same name | `bool` | `false` | no |
| replica_regions | List of replica region configurations | `list(object)` | `[]` | no |
| secret_string | Plaintext secret value (sensitive) | `string` | `null` | no |
| secret_binary | Base64-encoded binary secret value (sensitive) | `string` | `null` | no |
| version_stages | Staging labels for the secret version | `list(string)` | `null` | no |
| enable_rotation | Enable automatic rotation | `bool` | `false` | no |
| rotation_lambda_arn | ARN of the Lambda function for rotation | `string` | `null` | no |
| rotation_automatically_after_days | Days between automatic rotations (1–365) | `number` | `30` | no |
| secret_policy | JSON resource-based policy document | `string` | `null` | no |
| block_public_policy | Block broad resource-based policies | `bool` | `true` | no |
| tags | Map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| secret_id | The ID (ARN) of the secret |
| secret_arn | The ARN of the secret |
| secret_name | The name of the secret |
| secret_version_id | The version ID of the secret version |
| rotation_enabled | Whether automatic rotation is enabled |
| replica_arns | ARNs of replicated secrets in other regions |
