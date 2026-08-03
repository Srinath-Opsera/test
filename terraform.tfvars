region      = "us-east-1"
environment = "dev"

# ============================================================
# CloudWatch Log Groups
# ============================================================
log_groups = {
  crossaccount-demo-dev = {
    name              = "/aws/lambda/belc-platform-crossaccount-demo-dev"
    retention_in_days = 30
    tags = {
      grupo = "platform"
    }
  }
}

cloudwatch_tags = {}

# ============================================================
# Lambda Execution IAM Role
# ============================================================
lambda_role_name        = "belc-platform-crossaccount-demo-role-dev"
lambda_role_description = "Execution role for Lambda function belc-platform-crossaccount-demo-dev with cross-account S3 access"

lambda_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]

lambda_managed_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
]

lambda_force_detach_policies = true
lambda_max_session_duration  = 3600

lambda_role_tags = {
  grupo = "platform"
}

# ============================================================
# Lambda Security Group
# ============================================================
lambda_sg_name        = "belc-platform-crossaccount-demo-dev-sg"
lambda_sg_description = "Security group for Lambda function crossaccount-demo"

vpc_id = "vpc-xxxxxxxxxxxxxxxxx"

lambda_sg_egress_rules = [
  {
    description      = "Allow all outbound (S3 cross-account access)"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]

lambda_sg_tags = {
  grupo = "platform"
}

# ============================================================
# Cross-account S3 bucket (existing)
# ============================================================
crossaccount_s3_bucket_name = "test-crossaccount-opsera-demo"

# ============================================================
# Cross-account provider credentials (account 792373136340)
# ============================================================
assume_role_arn_acct_792373136340         = ""
assume_role_external_id_acct_792373136340 = ""

default_tags = {
  grupo = "platform"
  service = "crossaccount-demo"
  environment = "dev"
  managed_by = "cloudforge"
}
