# ============================================================
# Provider / Region
# ============================================================
region = "us-east-1"

# ============================================================
# Account identifiers
# ============================================================
aws_account_id       = "472496548172"
s3_bucket_account_id = "792373136340"

# ============================================================
# Multi-account: cross-account provider assume-role
# (values injected at deploy time by TFC workspace variables)
# ============================================================
assume_role_arn_acct_792373136340          = ""
assume_role_external_id_acct_792373136340  = ""

# ============================================================
# Environment
# ============================================================
environment = "dev"

# ============================================================
# VPC
# ============================================================
vpc_id = ""

# ============================================================
# ECR
# ============================================================
ecr_repository_name = "belc-platform-lambda-dev"

# ============================================================
# IAM Role
# ============================================================
lambda_role_name = "belc-platform-lambda-role-dev"

# ============================================================
# Security Group
# ============================================================
lambda_sg_name = "belc-platform-lambda-sg-dev"

# ============================================================
# Lambda Function
# ============================================================
lambda_function_name = "belc-platform-lambda-dev"

# Placeholder — replaced by CI/CD pipeline after first image push
lambda_image_uri = "472496548172.dkr.ecr.us-east-1.amazonaws.com/belc-platform-lambda-dev:latest"

# ============================================================
# Secrets Manager
# ============================================================
secret_name   = "belc-platform-lambda-secret-dev"
secret_string = ""

# ============================================================
# Cross-account S3 bucket
# ============================================================
s3_bucket_name = "test-crossaccount-opsera-demo"

default_tags = {
  grupo = "platform"
  service = "lambda"
  environment = "dev"
  managed_by = "cloudforge"
}
