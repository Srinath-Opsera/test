# ============================================================
# CloudWatch Log Group
# ============================================================
module "cloudwatch_log_group" {
  source = "./modules/aws-cloudwatch"

  log_groups = {
    "affinity-lambda" = {
      name              = "/aws/lambda/belc-affinity-affinity-lambda-dev"
      retention_in_days = 30
      tags = {
        service = "affinity-lambda"
        env     = "dev"
      }
    }
  }

  metric_alarms  = {}
  dashboards     = {}
  log_streams    = {}
  event_rules    = {}
  event_targets  = {}

  tags = {
    service = "affinity-lambda"
    env     = "dev"
  }
}

# ============================================================
# Lambda Execution IAM Role
# ============================================================
module "lambda_execution_role" {
  source = "./modules/terraform-aws-iam-role"

  name        = var.lambda_role_name
  description = var.lambda_role_description
  path        = "/"

  max_session_duration  = 3600
  force_detach_policies = true

  assume_role_principals = [
    {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]

  inline_policies = {
    secretsmanager-read = {
      name   = "secretsmanager-read"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Sid    = "SecretsManagerRead"
            Effect = "Allow"
            Action = [
              "secretsmanager:GetSecretValue",
              "secretsmanager:DescribeSecret",
              "secretsmanager:ListSecretVersionIds"
            ]
            Resource = module.secrets_manager.secret_arn
          }
        ]
      })
    }
  }

  tags = {
    service = "affinity-lambda"
    env     = "dev"
  }
}

# ============================================================
# Lambda Security Group
# ============================================================
module "lambda_security_group" {
  source = "./modules/terraform-aws-security-group"

  name        = var.lambda_sg_name
  description = var.lambda_sg_description
  vpc_id      = var.vpc_id

  ingress_rules = []

  egress_rules = [
    {
      description      = "Allow all outbound (S3, Secrets Manager, ECR)"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    }
  ]

  default_egress_allow_all = true
  revoke_rules_on_delete   = false

  tags = {
    service = "affinity-lambda"
    env     = "dev"
  }
}

# ============================================================
# Secrets Manager Secret
# ============================================================
module "secrets_manager" {
  source = "./modules/aws-secrets-manager-secret"

  name                          = var.secret_name
  description                   = var.secret_description
  kms_key_id                    = null
  recovery_window_in_days       = 30
  force_overwrite_replica_secret = false
  replica_regions               = []

  secret_string  = var.secret_string
  secret_binary  = null
  version_stages = null

  enable_rotation                   = false
  rotation_lambda_arn               = null
  rotation_automatically_after_days = 30

  secret_policy       = null
  block_public_policy = true

  tags = {
    service     = "affinity-lambda"
    env         = "dev"
    environment = "dev"
    managed_by  = "cloudforge"
  }
}

# ============================================================
# PERMISSION BRIDGE: Cross-account S3 access
# Identity-side IAM policy for Lambda role -> S3 bucket in account 792373136340
# ============================================================
resource "aws_iam_policy" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  name        = "affinity-lambda-s3-test-crossaccount-opsera-demo-policy-dev"
  description = "Least-privilege cross-account S3 access for affinity-lambda to test-crossaccount-opsera-demo"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name_test_crossaccount_opsera_demo}"
      },
      {
        Sid    = "S3ObjectAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name_test_crossaccount_opsera_demo}/*"
      }
    ]
  })

  tags = {
    service = "affinity-lambda"
    env     = "dev"
  }
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  role       = module.lambda_execution_role.role_name
  policy_arn = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}


# --- Resource Policies (auto-generated, preserving existing statements) ---

resource "aws_s3_bucket_policy" "existing_s3_bucket_test_crossaccount_opsera_demo_policy" {
  provider = aws.acct_792373136340
  bucket = var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name

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
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name}/*"
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
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name}"
        }
      ]
    })
  depends_on = [module.lambda_execution_role]
}
