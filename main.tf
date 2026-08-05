# IAM Policy for Secrets Manager Access
resource "aws_iam_policy" "secrets_manager_access" {
  name        = var.iam_policy_name
  description = "IAM policy granting Secrets Manager access for variable-format service"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ]
        Resource = "arn:aws:secretsmanager:us-east-1:*:secret:test/variable-format*"
      }
    ]
  })

  tags = var.iam_policy_tags
}

# Secrets Manager Secret
module "secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                          = var.secret_name
  description                   = var.secret_description
  kms_key_id                    = var.kms_key_id
  recovery_window_in_days       = var.recovery_window_in_days
  force_overwrite_replica_secret = var.force_overwrite_replica_secret
  secret_string                 = var.secret_string
  enable_rotation               = var.enable_rotation
  rotation_automatically_after_days = var.rotation_automatically_after_days
  block_public_policy           = var.block_public_policy
  tags                          = var.secret_tags
}
