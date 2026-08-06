region = "us-east-1"

# Cross-account provider (set at deploy time)
assume_role_arn_acct_792373136340          = ""
assume_role_external_id_acct_792373136340  = ""

# Existing resource
s3_bucket_name = "test-crossaccount-opsera-demo"

# VPC
vpc_name                 = "lambda-vpc"
vpc_availability_zones   = ["us-east-1a", "us-east-1b"]
vpc_public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
vpc_cidr_block           = "10.0.0.0/16"
vpc_enable_nat_gateway   = true
vpc_single_nat_gateway   = true
vpc_enable_dns_hostnames = true
vpc_enable_dns_support   = true
vpc_map_public_ip_on_launch = false
vpc_tags                 = {}

# Subnet
subnet_name                          = "lambda-subnet"
subnet_cidr_block                    = "10.0.1.0/24"
subnet_availability_zone             = "us-east-1a"
subnet_map_public_ip_on_launch       = false
subnet_assign_ipv6_address_on_creation = false
subnet_ipv6_cidr_block               = null
subnet_create_route_table            = true
subnet_route_table_id                = null
subnet_default_route_target_id       = null
subnet_default_route_target_type     = "gateway_id"
subnet_additional_routes             = []
subnet_tags                          = {}

# Security group
security_group_name                  = "lambda-sg"
security_group_description           = "Security group for Lambda function"
security_group_ingress_rules         = []
security_group_egress_rules = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
security_group_default_egress_allow_all = true
security_group_revoke_rules_on_delete   = false
security_group_tags                     = {}

# IAM role
iam_role_name = "lambda-execution-role"
iam_role_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]
iam_role_description         = "IAM role for Lambda to assume, with cross-account S3 access"
iam_role_path                = "/"
iam_role_max_session_duration = 3600
iam_role_managed_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionPolicy"
]
iam_role_inline_policies = {
  cross_account_s3_access = {
    name   = "cross_account_s3_access"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":[\"s3:GetObject\",\"s3:PutObject\",\"s3:DeleteObject\",\"s3:ListBucket\"],\"Resource\":[\"arn:aws:s3:::test-crossaccount-opsera-demo\",\"arn:aws:s3:::test-crossaccount-opsera-demo/*\"]}]}"
  }
}
iam_role_permissions_boundary = null
iam_role_force_detach_policies = false
iam_role_tags                  = {}

# ECR
ecr_name                 = "lambda-container-repo"
ecr_image_tag_mutability = "IMMUTABLE"
ecr_scan_on_push         = true
ecr_encryption_type      = "AES256"
ecr_kms_key_arn          = null
ecr_force_delete         = false
ecr_lifecycle_policy     = null
ecr_repository_policy    = null
ecr_replication_destinations = []
ecr_replication_filters      = []
ecr_tags                     = {}

# CloudWatch
log_groups = {
  lambda_function_log_group = {
    name              = "/aws/lambda/lambda-function"
    retention_in_days = 30
  }
}
metric_alarms = {}
dashboards    = {}
log_streams   = {}
event_rules   = {}
event_targets = {}
cloudwatch_tags = {}

# Lambda
lambda_function_name                   = "lambda-function"
lambda_environment                     = "dev"
lambda_description                     = "Lambda function that reads and writes to S3 bucket test-crossaccount-opsera-demo in AWS account 792373136340"
lambda_tags                            = {}
lambda_package_type                    = "Image"
lambda_image_uri                       = "472496548172.dkr.ecr.us-east-1.amazonaws.com/lambda-container-repo:latest"
lambda_architecture                    = "x86_64"
lambda_memory_size                     = 128
lambda_timeout                         = 30
lambda_reserved_concurrent_executions  = -1
lambda_layers                          = []
lambda_publish                         = false
lambda_environment_variables = {
  S3_BUCKET_NAME       = "test-crossaccount-opsera-demo"
  S3_BUCKET_ACCOUNT_ID = "792373136340"
}
lambda_create_iam_role                 = true
lambda_iam_role_name                   = "platform-lambda-function-dev"
lambda_existing_iam_role_arn           = null
lambda_additional_policy_arns          = []
lambda_inline_policy_json              = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":[\"s3:GetObject\",\"s3:PutObject\",\"s3:DeleteObject\",\"s3:ListBucket\"],\"Resource\":[\"arn:aws:s3:::test-crossaccount-opsera-demo\",\"arn:aws:s3:::test-crossaccount-opsera-demo/*\"]}]}"
lambda_create_cloudwatch_log_group     = true
lambda_log_retention_in_days           = 30
lambda_log_kms_key_id                  = null
lambda_tracing_mode                    = null
lambda_dead_letter_target_arn          = null
lambda_aliases                         = {}
lambda_create_function_url             = false
lambda_function_url_authorization_type = "AWS_IAM"
lambda_permissions                     = {}
lambda_event_source_mappings           = {}

default_tags = {
  team = "platform"
  service = "lambda-function"
  environment = "dev"
  managed_by = "cloudforge"
}
