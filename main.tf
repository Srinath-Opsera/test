module "cloudwatch_log_group" {
  source = "./modules/aws-cloudwatch"

  log_groups = var.log_groups

  tags = {
    service = "lambda"
    env     = "dev"
  }
}

module "lambda_execution_role" {
  source = "./modules/terraform-aws-iam-role"

  name        = var.iam_role_name
  description = var.iam_role_description
  path        = var.iam_role_path

  max_session_duration  = var.iam_role_max_session_duration
  force_detach_policies = var.iam_role_force_detach_policies

  assume_role_principals = var.assume_role_principals

  managed_policy_arns = var.managed_policy_arns

  tags = {}
}

module "lambda_security_group" {
  source = "./modules/terraform-aws-security-group"

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  ingress_rules            = var.ingress_rules
  egress_rules             = var.egress_rules
  default_egress_allow_all = var.default_egress_allow_all
  revoke_rules_on_delete   = var.revoke_rules_on_delete

  tags = {}
}

# ─── Permission Bridge: Cross-Account S3 (account 792373136340) ───────────────
resource "aws_iam_policy" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  name        = "lambda-s3-test-crossaccount-opsera-demo-policy-dev"
  description = "Identity-side policy granting Lambda role cross-account access to S3 bucket test-crossaccount-opsera-demo in account 792373136340"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name_test_crossaccount_opsera_demo}",
          "arn:aws:s3:::${var.s3_bucket_name_test_crossaccount_opsera_demo}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  role       = module.lambda_execution_role.role_name
  policy_arn = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}

# ─── Permission Bridge: Secrets Manager (account 472496548172) ────────────────
resource "aws_iam_policy" "cross_account_secretsmanager_affinity_test_secrets_access" {
  name        = "lambda-secretsmanager-affinity-test-secrets-policy-dev"
  description = "Policy granting Lambda role access to Secrets Manager secret affinity-test-secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "SecretsManagerAccess"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          "arn:aws:secretsmanager:${var.region}:${var.aws_account_id}:secret:${var.secrets_manager_secret_name}*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cross_account_secretsmanager_affinity_test_secrets_access" {
  role       = module.lambda_execution_role.role_name
  policy_arn = aws_iam_policy.cross_account_secretsmanager_affinity_test_secrets_access.arn
}


# --- Resource Policies (auto-generated, preserving existing statements) ---

resource "aws_s3_bucket_policy" "existing_s3_bucket_cross_account_policy" {
  provider = aws.acct_792373136340
  bucket = var.existing_s3_bucket_cross_account_bucket_name

  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "ExistingLegacyAccess",
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::792373136340:root"
          },
          "Action": [
            "s3:GetObject",
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::test-crossaccount-opsera-demo",
            "arn:aws:s3:::test-crossaccount-opsera-demo/*"
          ]
        },
        {
          "Sid": "Allowlambda_execution_iam_roleObjectAccess",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${module.lambda_execution_role.role_arn}"
          },
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_cross_account_bucket_name}/*"
        },
        {
          "Sid": "Allowlambda_execution_iam_roleListBucket",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${module.lambda_execution_role.role_arn}"
          },
          "Action": [
            "s3:ListBucket"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_cross_account_bucket_name}"
        }
      ]
    })
  depends_on = [module.lambda_execution_role]
}

# --- MANUAL ACTION REQUIRED ---
# Could not read the existing policy for secretsmanager "affinity-test-secrets"
# in cross-account (provider: aws.acct_472496548172).
# To avoid overwriting existing access, the following policy statements
# must be ADDED to the resource policy manually (via AWS Console or CLI):
#
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Sid": "Allowlambda_execution_iam_roleSecretsAccess",
#         "Effect": "Allow",
#         "Principal": {
#           "AWS": "__TF_ROLE:Lambda Execution IAM Role__"
#         },
#         "Action": [
#           "secretsmanager:GetSecretValue",
#           "secretsmanager:DescribeSecret"
#         ],
#         "Resource": "__TF_EXPR:${var.secrets_manager_secret_id}__"
#       }
#     ]
#   }
#
# --- END MANUAL ACTION ---
