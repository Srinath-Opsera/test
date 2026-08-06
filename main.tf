# VPC
module "vpc--vpc" {
  source  = "app.terraform.io/TF01/vpc/aws"
  version = "~> 1.0.0"

  name                    = var.vpc_name
  cidr_block              = var.vpc_cidr_block
  availability_zones      = var.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  enable_dns_support      = var.enable_dns_support
  enable_dns_hostnames    = var.enable_dns_hostnames
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  tags                    = {}
}

# Lambda Security Group
module "security-group--lambda-security-group" {
  source  = "app.terraform.io/TF01/security-group/aws"
  version = "~> 1.0.0"

  name                     = var.lambda_sg_name
  description              = var.lambda_sg_description
  vpc_id                   = module.vpc--vpc.vpc_id
  ingress_rules            = []
  egress_rules             = []
  default_egress_allow_all = true
  revoke_rules_on_delete   = false
  tags                     = {}
}

# RDS Security Group
module "security-group--aurora-postgresql-rds-security-group" {
  source  = "app.terraform.io/TF01/security-group/aws"
  version = "~> 1.0.0"

  name        = var.rds_sg_name
  description = var.rds_sg_description
  vpc_id      = module.vpc--vpc.vpc_id
  ingress_rules = [
    {
      description      = "Allow inbound from Lambda SG"
      from_port        = 5432
      to_port          = 5432
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      security_groups  = [module.security-group--lambda-security-group.security_group_id]
      self             = false
    }
  ]
  egress_rules             = []
  default_egress_allow_all = true
  revoke_rules_on_delete   = false
  tags                     = {}
}

# Private Subnet 1
module "subnet--private-subnet" {
  source  = "app.terraform.io/TF01/subnet/aws"
  version = "~> 1.0.0"

  name                            = "${var.private_subnet_name}-1"
  vpc_id                          = module.vpc--vpc.vpc_id
  cidr_block                      = var.private_subnet_cidr_1
  availability_zone               = var.private_subnet_az_1
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false
  ipv6_cidr_block                 = null
  additional_routes               = []
  default_route_target_type       = "nat_gateway_id"
  default_route_target_id         = length(module.vpc--vpc.nat_gateway_ids) > 0 ? module.vpc--vpc.nat_gateway_ids[0] : null
  create_route_table              = true
  tags                            = {}
}

# Private Subnet 2 (for DB subnet group multi-AZ)
module "subnet--db-subnet-group" {
  source  = "app.terraform.io/TF01/subnet/aws"
  version = "~> 1.0.0"

  name                            = "${var.private_subnet_name}-2"
  vpc_id                          = module.vpc--vpc.vpc_id
  cidr_block                      = var.private_subnet_cidr_2
  availability_zone               = var.private_subnet_az_2
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false
  ipv6_cidr_block                 = null
  additional_routes               = []
  default_route_target_type       = "nat_gateway_id"
  default_route_target_id         = length(module.vpc--vpc.nat_gateway_ids) > 0 ? module.vpc--vpc.nat_gateway_ids[0] : null
  create_route_table              = true
  tags                            = {}
}

# DB Subnet Group
resource "aws_db_subnet_group" "opsera_test" {
  name = var.db_subnet_group_name
  subnet_ids = [
    module.subnet--private-subnet.subnet_id,
    module.subnet--db-subnet-group.subnet_id
  ]

  tags = {
    Name = var.db_subnet_group_name
  }
}

# S3 Bucket
module "s3--s3-bucket" {
  source  = "app.terraform.io/TF01/s3/aws"
  version = "~> 1.0.0"

  bucket_name             = var.bucket_name
  versioning_enabled      = var.versioning_enabled
  sse_algorithm           = var.sse_algorithm
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  force_destroy           = var.force_destroy
  lifecycle_rules         = []
  bucket_policy_json      = null
  kms_master_key_id       = null
  tags                    = {}
}

# CloudWatch Log Group for Lambda
module "cloudwatch--cloudwatch-log-group-lambda" {
  source  = "app.terraform.io/TF01/cloudwatch/aws"
  version = "~> 1.0.1"

  log_groups = {
    lambda_log_group = {
      name              = var.lambda_log_group_name
      retention_in_days = var.lambda_log_retention_days
      kms_key_id        = null
      tags              = {}
    }
  }
  event_rules   = {}
  event_targets = {}
  log_streams   = {}
  dashboards    = {}
  metric_alarms = {}
  tags          = {}
}

# Secrets Manager Secret
module "aws-secrets-manager-secret" {
  source = "./modules/aws-secrets-manager-secret"

  name                              = var.secret_name
  description                       = var.secret_description
  kms_key_id                        = null
  recovery_window_in_days           = var.recovery_window_in_days
  force_overwrite_replica_secret    = false
  replica_regions                   = []
  secret_string                     = var.secret_string
  secret_is_json                    = false
  secret_string_json                = {}
  secret_binary                     = null
  version_stages                    = null
  enable_rotation                   = false
  rotation_lambda_arn               = null
  rotation_automatically_after_days = 30
  secret_policy                     = null
  block_public_policy               = true
  tags                              = {}
}

# Lambda Function
module "lambda--lambda-function" {
  source  = "app.terraform.io/TF01/lambda/aws"
  version = "~> 1.0.0"

  function_name                  = var.lambda_function_name
  runtime                        = var.lambda_runtime
  handler                        = var.lambda_handler
  package_type                   = var.lambda_package_type
  filename                       = var.lambda_filename
  description                    = ""
  memory_size                    = var.lambda_memory_size
  timeout                        = var.lambda_timeout
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions
  architectures                  = var.lambda_architectures
  environment_variables          = var.lambda_environment_variables
  log_retention_days             = var.lambda_log_retention_days
  additional_policy_arns         = var.lambda_additional_policy_arns
  image_uri                      = null
  source_code_hash               = null
  tags                           = {}
}

# RDS Aurora PostgreSQL
module "rds--aurora-postgresql-rds" {
  source  = "app.terraform.io/TF01/rds/aws"
  version = "~> 1.0.0"

  identifier              = var.rds_identifier
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  username                = var.rds_username
  password                = var.rds_password
  db_name                 = var.rds_db_name
  db_subnet_group_name    = aws_db_subnet_group.opsera_test.name
  vpc_security_group_ids  = [module.security-group--aurora-postgresql-rds-security-group.security_group_id]
  instance_class          = var.rds_instance_class
  allocated_storage       = var.rds_allocated_storage
  max_allocated_storage   = var.rds_max_allocated_storage
  storage_type            = var.rds_storage_type
  storage_encrypted       = var.rds_storage_encrypted
  kms_key_id              = null
  multi_az                = var.rds_multi_az
  backup_retention_period = var.rds_backup_retention_period
  skip_final_snapshot     = var.rds_skip_final_snapshot
  deletion_protection     = var.rds_deletion_protection
  tags                    = {}
}
