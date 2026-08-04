variable "region" {
  type        = string
  description = "AWS region for resource deployment"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# ============================================================
# IAM Role variables
# ============================================================
variable "lambda_role_name" {
  type        = string
  description = "Name of the Lambda execution IAM role"
}

variable "lambda_role_description" {
  type        = string
  description = "Description of the Lambda execution IAM role"
  default     = "IAM execution role for Lambda function affinity-lambda"
}

# ============================================================
# Security Group variables
# ============================================================
variable "lambda_sg_name" {
  type        = string
  description = "Name of the Lambda security group"
}

variable "lambda_sg_description" {
  type        = string
  description = "Description of the Lambda security group"
  default     = "Security group for Lambda function outbound access"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the Lambda security group will be created"
}

# ============================================================
# Secrets Manager variables
# ============================================================
variable "secret_name" {
  type        = string
  description = "Name of the Secrets Manager secret"
}

variable "secret_description" {
  type        = string
  description = "Description of the Secrets Manager secret"
  default     = "Secrets for affinity-lambda including AFFINITY_API_TOKEN, PGPASSWORD_QAS, and PGPASSWORD_DEV"
}

variable "secret_string" {
  type        = string
  description = "JSON string containing the secret key-value pairs"
  sensitive   = true
  default     = null
}

# ============================================================
# Permission Bridge variables
# ============================================================
variable "s3_bucket_name_test_crossaccount_opsera_demo" {
  type        = string
  description = "Name of the existing cross-account S3 bucket in account 792373136340"
  default     = "test-crossaccount-opsera-demo"
}

variable "assume_role_arn_acct_792373136340" {
  type        = string
  description = "ARN of the IAM role to assume in account 792373136340"
}

variable "assume_role_external_id_acct_792373136340" {
  type        = string
  description = "Optional external ID for assuming the role in account 792373136340"
  default     = ""
}


# --- Variables for resource policy injection ---

variable "existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name" {
  description = "Name of the existing S3 bucket for policy attachment"
  type        = string
  default     = "test-crossaccount-opsera-demo"
}
