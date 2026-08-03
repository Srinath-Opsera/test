# ============================================================
# Provider / Region
# ============================================================
variable "region" {
  type        = string
  description = "AWS region for all resources"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# ============================================================
# Account identifiers
# ============================================================
variable "aws_account_id" {
  type        = string
  description = "Primary AWS account ID (472496548172)"
  default     = "472496548172"
}

variable "s3_bucket_account_id" {
  type        = string
  description = "AWS account ID that owns the cross-account S3 bucket (792373136340)"
  default     = "792373136340"
}

# ============================================================
# Multi-account: additional provider assume-role variables
# ============================================================
variable "assume_role_arn_acct_792373136340" {
  type        = string
  description = "IAM role ARN to assume in account 792373136340 for cross-account provider"
}

variable "assume_role_external_id_acct_792373136340" {
  type        = string
  description = "Optional external ID for assuming the role in account 792373136340"
  default     = ""
}

# ============================================================
# Environment
# ============================================================
variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod, test, qa)"
  default     = "dev"
}

# ============================================================
# VPC
# ============================================================
variable "vpc_id" {
  type        = string
  description = "VPC ID where the Lambda security group will be created"
}

# ============================================================
# ECR
# ============================================================
variable "ecr_repository_name" {
  type        = string
  description = "Name of the ECR repository for the Lambda container image"
  default     = "belc-platform-lambda-dev"
}

# ============================================================
# IAM Role
# ============================================================
variable "lambda_role_name" {
  type        = string
  description = "Name of the Lambda execution IAM role"
  default     = "belc-platform-lambda-role-dev"
}

# ============================================================
# Security Group
# ============================================================
variable "lambda_sg_name" {
  type        = string
  description = "Name of the Lambda security group"
  default     = "belc-platform-lambda-sg-dev"
}

# ============================================================
# Lambda Function
# ============================================================
variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
  default     = "belc-platform-lambda-dev"
}

# Placeholder — replaced by CI/CD pipeline after first image push
variable "lambda_image_uri" {
  type        = string
  description = "ECR image URI for the Lambda container image deployment. Placeholder until first image is pushed."
  default     = "472496548172.dkr.ecr.us-east-1.amazonaws.com/belc-platform-lambda-dev:latest"
}

# ============================================================
# Secrets Manager
# ============================================================
variable "secret_name" {
  type        = string
  description = "Name of the Secrets Manager secret"
  default     = "belc-platform-lambda-secret-dev"
}

variable "secret_string" {
  type        = string
  description = "JSON string containing the secret key-value pairs"
  sensitive   = true
  default     = null
}

# ============================================================
# Cross-account S3 bucket
# ============================================================
variable "s3_bucket_name" {
  type        = string
  description = "Name of the existing cross-account S3 bucket in account 792373136340"
  default     = "test-crossaccount-opsera-demo"
}


# --- Variables for resource policy injection ---

variable "existing_s3_bucket_cross_account_bucket_name" {
  description = "Name of the existing S3 bucket for policy attachment"
  type        = string
  default     = "test-crossaccount-opsera-demo"
}
