# ============================================================
# CloudWatch Log Group
# ============================================================
module "cloudwatch_log_group" {
  source = "./modules/aws-cloudwatch"

  log_groups = {
    "belc-platform-lambda-dev" = {
      name              = "/aws/lambda/belc-platform-lambda-dev"
      retention_in_days = 30
      kms_key_id        = null
      tags = {
        service = "lambda"
        env     = "dev"
        grupo   = "platform"
      }
    }
  }

  metric_alarms  = {}
  dashboards     = {}
  log_streams    = {}
  event_rules    = {}
  event_targets  = {}

  tags = {
    service = "lambda"
    env     = "dev"
    grupo   = "platform"
  }
}

# ============================================================
# ECR Repository
# ============================================================
module "ecr_repository" {
  source = "./modules/aws-ecr-repository"

  name                  = var.ecr_repository_name
  image_tag_mutability  = "MUTABLE"
  scan_on_push          = true
  encryption_type       = "AES256"
  kms_key_arn           = null
  force_delete          = false
  lifecycle_policy      = null
  repository_policy     = null
  replication_destinations = []
  replication_filters   = []

  tags = {
    service = "lambda"
    env     = "dev"
    grupo   = "platform"
  }
}

# ============================================================
# Lambda Execution IAM Role
# ============================================================
module "lambda_execution_role" {
  source = "./modules/terraform-aws-iam-role"

  name        = var.lambda_role_name
  description = "IAM execution role for Lambda function belc-platform-lambda-dev"
  path        = "/"

  assume_role_principals = [
    {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  ]

  max_session_duration = 3600

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]

  inline_policies = {
    "s3-crossaccount-access" = {
      name   = "s3-crossaccount-access"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject",
              "s3:ListBucket"
            ]
            Resource = [
              "arn:aws:s3:::test-crossaccount-opsera-demo",
              "arn:aws:s3:::test-crossaccount-opsera-demo/*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "secretsmanager:GetSecretValue",
              "secretsmanager:DescribeSecret"
            ]
            Resource = "arn:aws:secretsmanager:${var.region}:${var.aws_account_id}:secret:belc-platform-lambda-secret-dev*"
          }
        ]
      })
    }
  }

  permissions_boundary  = null
  force_detach_policies = true

  tags = {
    service     = "lambda"
    env         = "dev"
    grupo       = "platform"
    environment = "dev"
    managed_by  = "cloudforge"
  }
}

# ============================================================
# Lambda Security Group
# ============================================================
module "lambda_security_group" {
  source = "./modules/terraform-aws-security-group"

  name        = var.lambda_sg_name
  vpc_id      = var.vpc_id
  description = "Security group for Lambda function outbound access"

  ingress_rules = []

  egress_rules = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      security_groups  = []
      self             = false
    }
  ]

  default_egress_allow_all  = true
  revoke_rules_on_delete    = false

  tags = {
    service     = "lambda"
    env         = "dev"
    grupo       = "platform"
    environment = "dev"
    managed_by  = "cloudforge"
  }
}

# ============================================================
# Lambda Function
# ============================================================
module "lambda_function" {
  source = "./modules/aws-lambda-function"

  function_name = var.lambda_function_name
  environment   = var.environment
  description   = "Lambda function that reads and writes to S3 bucket in cross-account AWS account 792373136340"

  runtime      = "nodejs20.x"
  handler      = null
  architecture = "x86_64"
  package_type = "Image"

  # Placeholder image URI — replaced by CI/CD pipeline after first image push
  image_uri         = var.lambda_image_uri
  filename          = null
  source_code_hash  = null
  s3_bucket         = null
  s3_key            = null
  s3_object_version = null

  timeout                       = 30
  memory_size                   = 128
  reserved_concurrent_executions = null
  ephemeral_storage_size        = null

  environment_variables = {
    S3_BUCKET_NAME       = var.s3_bucket_name
    S3_BUCKET_ACCOUNT_ID = var.s3_bucket_account_id
    AWS_ACCOUNT_ID       = var.aws_account_id
  }

  layer_arns = []

  create_iam_role      = false
  existing_role_arn    = module.lambda_execution_role.role_arn
  iam_role_name        = null
  permissions_boundary_arn = null
  additional_policy_arns   = []
  inline_policy_json       = null

  vpc_subnet_ids         = null
  vpc_id                 = null
  vpc_security_group_ids = []
  create_security_group  = false
  security_group_name    = null

  create_cloudwatch_log_group = false
  log_retention_in_days       = 30
  log_kms_key_id              = null
  kms_key_arn                 = null
  tracing_mode                = null
  dead_letter_target_arn      = null
  file_system_arn             = null
  file_system_local_mount_path = null

  publish              = true
  create_alias         = false
  alias_name           = "live"
  alias_description    = ""
  alias_function_version = null
  snap_start_enabled   = false

  create_function_url            = false
  function_url_authorization_type = "AWS_IAM"
  function_url_cors              = null

  allowed_triggers      = {}
  event_source_mappings = {}

  tags = {
    service     = "lambda"
    env         = "dev"
    grupo       = "platform"
    environment = "dev"
    managed_by  = "cloudforge"
  }
}

# ============================================================
# Secrets Manager Secret
# ============================================================
module "secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name        = var.secret_name
  description = "Secrets for Lambda function that accesses cross-account S3 bucket in account 792373136340"

  kms_key_id                    = null
  recovery_window_in_days       = 7
  force_overwrite_replica_secret = false
  replica_regions               = []

  secret_string  = var.secret_string
  secret_binary  = null
  version_stages = null

  enable_rotation                  = false
  rotation_lambda_arn              = null
  rotation_automatically_after_days = 30
  secret_policy                    = null
  block_public_policy              = true

  tags = {
    service     = "lambda"
    env         = "dev"
    grupo       = "platform"
    environment = "dev"
    managed_by  = "cloudforge"
  }
}

# ============================================================
# PERMISSION BRIDGE: Cross-account S3 access (identity-side)
# Consumer: Lambda Execution IAM Role (account 472496548172)
# Existing resource: S3 bucket in account 792373136340
# ============================================================
resource "aws_iam_policy" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  name        = "lambda-s3-test-crossaccount-opsera-demo-policy-dev"
  description = "Identity-side policy granting Lambda cross-account access to S3 bucket test-crossaccount-opsera-demo in account 792373136340"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountS3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })

  tags = {
    service     = "lambda"
    env         = "dev"
    grupo       = "platform"
    environment = "dev"
    managed_by  = "cloudforge"
  }
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  role       = module.lambda_execution_role.role_name
  policy_arn = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
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
          "Sid": "Allowlambda_functionObjectAccess",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${module.lambda_function.role_arn}"
          },
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_cross_account_bucket_name}/*"
        },
        {
          "Sid": "Allowlambda_functionListBucket",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${module.lambda_function.role_arn}"
          },
          "Action": [
            "s3:ListBucket"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_cross_account_bucket_name}"
        }
      ]
    })
  depends_on = [module.lambda_function]
}
