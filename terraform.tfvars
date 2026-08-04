# Base template — per-environment files are generated below.
# Environments: dev, qas

region = "us-east-1"

# IAM Role
lambda_role_name        = "belc-affinity-affinity-lambda-role-dev"
lambda_role_description = "IAM execution role for Lambda function affinity-lambda"

# Security Group
lambda_sg_name        = "belc-affinity-affinity-lambda-sg-dev"
lambda_sg_description = "Security group for Lambda function outbound access"
vpc_id                = "vpc-xxxxxxxxxxxxxxxxx"

# Secrets Manager
secret_name        = "affinity-affinity-lambda-dev"
secret_description = "Secrets for affinity-lambda including AFFINITY_API_TOKEN, PGPASSWORD_QAS, and PGPASSWORD_DEV"
secret_string = ""

# Permission Bridge — existing cross-account S3 bucket
s3_bucket_name_test_crossaccount_opsera_demo = "test-crossaccount-opsera-demo"

# Cross-account provider credentials (account 792373136340)
assume_role_arn_acct_792373136340          = ""
assume_role_external_id_acct_792373136340  = ""

default_tags = {
  grupo = "affinity"
  service = "affinity-lambda"
  environment = "dev"
  managed_by = "cloudforge"
}
