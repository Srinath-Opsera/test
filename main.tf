module "terraform-aws-vpc--vpc" {
  source = "./modules/terraform-aws-vpc"

  name                 = var.vpc_name
  availability_zones   = var.vpc_availability_zones
  public_subnet_cidrs  = var.vpc_public_subnet_cidrs
  private_subnet_cidrs = var.vpc_private_subnet_cidrs
  cidr_block           = var.vpc_cidr_block
  enable_nat_gateway   = var.vpc_enable_nat_gateway
  single_nat_gateway   = var.vpc_single_nat_gateway
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
  tags                 = var.vpc_tags
}

module "terraform-aws-subnet--subnet" {
  source = "./modules/terraform-aws-subnet"

  name                          = var.subnet_name
  vpc_id                        = module.terraform-aws-vpc--vpc.vpc_id
  cidr_block                    = var.subnet_cidr_block
  availability_zone             = var.subnet_availability_zone
  map_public_ip_on_launch       = var.subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block               = var.subnet_ipv6_cidr_block
  create_route_table            = var.subnet_create_route_table
  route_table_id                = var.subnet_route_table_id
  default_route_target_id       = var.subnet_default_route_target_id
  default_route_target_type     = var.subnet_default_route_target_type
  additional_routes             = var.subnet_additional_routes
  tags                          = var.subnet_tags
}

module "terraform-aws-security-group--lambda-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.security_group_name
  vpc_id                  = module.terraform-aws-vpc--vpc.vpc_id
  description             = var.security_group_description
  ingress_rules           = var.security_group_ingress_rules
  egress_rules            = var.security_group_egress_rules
  default_egress_allow_all = var.security_group_default_egress_allow_all
  revoke_rules_on_delete  = var.security_group_revoke_rules_on_delete
  tags                    = var.security_group_tags
}

module "terraform-aws-iam-role--lambda-execution-iam-role" {
  source = "./modules/terraform-aws-iam-role"

  name                    = var.iam_role_name
  assume_role_principals  = var.iam_role_assume_role_principals
  description             = var.iam_role_description
  path                    = var.iam_role_path
  max_session_duration    = var.iam_role_max_session_duration
  managed_policy_arns     = var.iam_role_managed_policy_arns
  inline_policies         = var.iam_role_inline_policies
  permissions_boundary    = var.iam_role_permissions_boundary
  force_detach_policies   = var.iam_role_force_detach_policies
  tags                    = var.iam_role_tags
}

module "aws-ecr-repository" {
  source = "./modules/aws-ecr-repository"

  name                     = var.ecr_name
  image_tag_mutability     = var.ecr_image_tag_mutability
  scan_on_push             = var.ecr_scan_on_push
  encryption_type          = var.ecr_encryption_type
  kms_key_arn              = var.ecr_kms_key_arn
  force_delete             = var.ecr_force_delete
  lifecycle_policy         = var.ecr_lifecycle_policy
  repository_policy        = var.ecr_repository_policy
  replication_destinations = var.ecr_replication_destinations
  replication_filters      = var.ecr_replication_filters
  tags                     = var.ecr_tags
}

module "aws-cloudwatch--cloudwatch-log-group" {
  source = "./modules/aws-cloudwatch"

  log_groups    = var.log_groups
  metric_alarms = var.metric_alarms
  dashboards    = var.dashboards
  log_streams   = var.log_streams
  event_rules   = var.event_rules
  event_targets = var.event_targets
  tags          = var.cloudwatch_tags
}

module "aws-lambda-function" {
  source = "./modules/aws-lambda-function"

  function_name                  = var.lambda_function_name
  environment                    = var.lambda_environment
  description                    = var.lambda_description
  tags                           = var.lambda_tags
  package_type                   = var.lambda_package_type
  image_uri                      = var.lambda_image_uri
  architecture                   = var.lambda_architecture
  memory_size                    = var.lambda_memory_size
  timeout                        = var.lambda_timeout
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions
  layers                         = var.lambda_layers
  publish                        = var.lambda_publish
  environment_variables          = var.lambda_environment_variables
  create_iam_role                = var.lambda_create_iam_role
  iam_role_name                  = var.lambda_iam_role_name
  existing_iam_role_arn          = var.lambda_existing_iam_role_arn
  additional_policy_arns         = var.lambda_additional_policy_arns
  inline_policy_json             = var.lambda_inline_policy_json
  vpc_subnet_ids                 = module.terraform-aws-vpc--vpc.private_subnet_ids
  vpc_id                         = module.terraform-aws-vpc--vpc.vpc_id
  vpc_security_group_ids         = [module.terraform-aws-security-group--lambda-security-group.security_group_id]
  create_security_group          = false
  create_cloudwatch_log_group    = var.lambda_create_cloudwatch_log_group
  log_retention_in_days          = var.lambda_log_retention_in_days
  log_kms_key_id                 = var.lambda_log_kms_key_id
  tracing_mode                   = var.lambda_tracing_mode
  dead_letter_target_arn         = var.lambda_dead_letter_target_arn
  aliases                        = var.lambda_aliases
  create_function_url            = var.lambda_create_function_url
  function_url_authorization_type = var.lambda_function_url_authorization_type
  lambda_permissions             = var.lambda_permissions
  event_source_mappings          = var.lambda_event_source_mappings
}

# Cross-account S3 access policy for Lambda Execution IAM Role
resource "aws_iam_policy" "cross_account_s3_test_crossaccount_opsera_demo_access" {
  name        = "lambda-function-s3-test-crossaccount-opsera-demo-policy-dev"
  description = "Read and write access to S3 bucket test-crossaccount-opsera-demo"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
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
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_test_crossaccount_opsera_demo_access_lambda_execution_role" {
  role       = module.terraform-aws-iam-role--lambda-execution-iam-role.role_name
  policy_arn = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}

resource "aws_iam_role_policy_attachment" "cross_account_s3_test_crossaccount_opsera_demo_access_lambda_function_role" {
  role       = module.aws-lambda-function.iam_role_name
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
          "Sid": "Allowlambda_functionObjectAccess",
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::472496548172:role/${module.aws-lambda-function.iam_role_name}"
          },
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name}/*"
        },
        {
          "Sid": "Allowlambda_functionListBucket",
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::472496548172:role/${module.aws-lambda-function.iam_role_name}"
          },
          "Action": [
            "s3:ListBucket"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name}"
        }
      ]
    })
  depends_on = [module.aws-lambda-function]
}
