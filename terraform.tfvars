# Base template — per-environment files are generated below.
# Environments: dev, qas, prd

region = "us-east-1"

# VPC
vpc_name             = "opsera-test-dev"
vpc_cidr_block       = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
enable_dns_support   = true
enable_dns_hostnames = true
map_public_ip_on_launch = true
enable_nat_gateway   = true
single_nat_gateway   = true

# Private Subnets
private_subnet_name   = "private-opsera-test-dev"
private_subnet_cidr_1 = "10.0.10.0/24"
private_subnet_az_1   = "us-east-1a"
private_subnet_cidr_2 = "10.0.11.0/24"
private_subnet_az_2   = "us-east-1b"

# DB Subnet Group
db_subnet_group_name = "dbsubnetgroup-opsera-test-dev"

# Security Groups
lambda_sg_name        = "lambda-opsera-test-dev"
lambda_sg_description = "Security group for Lambda function outbound access to RDS and S3"
rds_sg_name           = "rds-opsera-test-dev"
rds_sg_description    = "Security group for Aurora PostgreSQL - allows inbound from Lambda SG"

# S3
bucket_name             = "Belc-opsera-test-dev"
versioning_enabled      = true
sse_algorithm           = "AES256"
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
force_destroy           = false

# CloudWatch
lambda_log_group_name     = "/aws/lambda/Lambda-Opsera-test-dev"
lambda_log_retention_days = 30

# Secrets Manager
secret_name               = "opsera-opsera-test-dev"
secret_description        = "Aurora PostgreSQL credentials for Lambda access"
recovery_window_in_days   = 30
secret_string = ""

# Lambda
lambda_function_name                  = "Lambda-Opsera-test-dev"
lambda_runtime                        = "python3.12"
lambda_handler                        = "index.handler"
lambda_package_type                   = "Zip"
lambda_filename                       = "Lambda-Opsera-test-dev"
lambda_memory_size                    = 128
lambda_timeout                        = 30
lambda_reserved_concurrent_executions = -1
lambda_architectures                  = ["x86_64"]
lambda_environment_variables          = {}
lambda_additional_policy_arns         = []

# RDS
rds_identifier              = "opsera-opsera-test-dev"
rds_engine                  = "aurora-postgresql"
rds_engine_version          = "15.4"
rds_username                = "postgres"
rds_password = ""
rds_db_name                 = "opsera_opsera_test_dev"
rds_instance_class          = "db.t3.micro"
rds_allocated_storage       = 20
rds_max_allocated_storage   = 0
rds_storage_type            = "gp3"
rds_storage_encrypted       = true
rds_multi_az                = true
rds_backup_retention_period = 7
rds_skip_final_snapshot     = false
rds_deletion_protection     = true

default_tags = {
  team = "opsera"
  service = "opsera-test"
  environment = "dev"
  managed_by = "cloudforge"
}
