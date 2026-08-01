# affinity-test — dev
# Provisions: Lambda Execution IAM Role + Secrets Manager Secret

locals {
  secret_arn = module.affinity_test_secret.secret_arn
}

# ── Secrets Manager Secret ────────────────────────────────────────────────────
module "affinity_test_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                          = var.secret_name
  description                   = var.secret_description
  kms_key_id                    = null
  recovery_window_in_days       = var.recovery_window_in_days
  force_overwrite_replica_secret = false
  replica_regions               = []
  secret_string                 = var.secret_string
  secret_binary                 = null
  version_stages                = null
  enable_rotation               = false
  rotation_lambda_arn           = null
  rotation_automatically_after_days = 30
  secret_policy                 = null
  block_public_policy           = true

  tags = {
    Name = var.secret_name
  }
}

# ── Lambda Execution IAM Role ─────────────────────────────────────────────────
module "lambda_execution_role" {
  source = "./modules/terraform-aws-iam-role"

  name        = var.iam_role_name
  description = var.iam_role_description
  path        = "/"
  max_session_duration  = 3600
  force_detach_policies = true
  permissions_boundary  = null

  assume_role_principals = var.assume_role_principals

  managed_policy_arns = var.managed_policy_arns

  inline_policies = {
    secrets_access = {
      name   = "secrets-access"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Sid      = "AllowGetSecret"
            Effect   = "Allow"
            Action   = ["secretsmanager:GetSecretValue"]
            Resource = local.secret_arn
          }
        ]
      })
    }
  }

  tags = {
    Name = var.iam_role_name
  }
}
