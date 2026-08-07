module "aws_cloudwatch" {
  source = "./modules/aws-cloudwatch"

  log_groups = var.log_groups
  tags       = var.cloudwatch_tags
}

module "terraform_aws_iam_role" {
  source = "./modules/terraform-aws-iam-role"

  name                   = var.name
  assume_role_principals = var.assume_role_principals
  description            = var.description
  path                   = var.path
  max_session_duration   = var.max_session_duration
  managed_policy_arns    = var.managed_policy_arns
  force_detach_policies  = var.force_detach_policies
  tags                   = var.iam_role_tags
}

module "terraform_aws_security_group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.security_group_name
  vpc_id                   = var.vpc_id
  description              = var.security_group_description
  ingress_rules            = var.ingress_rules
  egress_rules             = var.egress_rules
  default_egress_allow_all = var.default_egress_allow_all
  revoke_rules_on_delete   = var.revoke_rules_on_delete
  tags                     = var.security_group_tags
}

module "aws_ecr_repository" {
  source = "./modules/aws-ecr-repository"

  name                     = var.repository_name
  image_tag_mutability     = var.image_tag_mutability
  scan_on_push             = var.scan_on_push
  encryption_type          = var.encryption_type
  kms_key_arn              = var.ecr_kms_key_arn
  force_delete             = var.force_delete
  lifecycle_policy         = var.lifecycle_policy
  repository_policy        = var.repository_policy
  replication_destinations = var.replication_destinations
  replication_filters      = var.replication_filters
  tags                     = var.ecr_tags
}

module "aws_lambda_function" {
  source = "./modules/aws-lambda-function"

  function_name               = var.function_name
  environment                 = var.environment
  description                 = var.lambda_description
  runtime                     = var.runtime
  handler                     = var.handler
  architecture                = var.architecture
  image_uri                   = var.image_uri
  timeout                     = var.timeout
  memory_size                 = var.memory_size
  publish                     = var.publish
  environment_variables       = var.environment_variables
  layer_arns                  = var.layer_arns
  create_iam_role             = var.create_iam_role
  existing_role_arn           = module.terraform_aws_iam_role.role_arn
  vpc_subnet_ids              = var.vpc_subnet_ids
  vpc_security_group_ids      = [module.terraform_aws_security_group.security_group_id]
  create_security_group       = false
  create_cloudwatch_log_group = false
  log_retention_in_days       = var.log_retention_in_days
  tags                        = var.lambda_tags
}

module "aws_secrets_manager_secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                              = var.secret_name
  recovery_window_in_days           = var.recovery_window_in_days
  force_overwrite_replica_secret    = var.force_overwrite_replica_secret
  secret_string                     = length(var.secret_key_value_pairs) > 0 ? jsonencode(var.secret_key_value_pairs) : null
  enable_rotation                   = var.enable_rotation
  rotation_automatically_after_days = var.rotation_automatically_after_days
  block_public_policy               = var.block_public_policy
  tags                              = var.secrets_tags
}

resource "aws_iam_policy" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  name        = "affinity-test-s3-test-crossaccount-opsera-demo-policy-dev"
  description = "Read and write access to S3 bucket test-crossaccount-opsera-demo"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3CrossAccountAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.cross_account_s3_bucket_name}",
          "arn:aws:s3:::${var.cross_account_s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  role       = module.terraform_aws_iam_role.role_name
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
            "AWS": "${module.aws_lambda_function.role_arn}"
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
            "AWS": "${module.aws_lambda_function.role_arn}"
          },
          "Action": [
            "s3:ListBucket"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_cross_account_bucket_name}"
        }
      ]
    })
  depends_on = [module.aws_lambda_function]
}
