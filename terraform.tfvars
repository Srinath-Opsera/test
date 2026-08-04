region         = "us-east-1"
aws_account_id = "472496548172"

# ─── Cross-account provider ───────────────────────────────────────────────────
assume_role_arn_acct_792373136340         = ""
assume_role_external_id_acct_792373136340 = ""

# ─── CloudWatch Log Group ─────────────────────────────────────────────────────
log_groups = {
  "belc-affinity-lambda-dev" = {
    name              = "/aws/lambda/belc-affinity-lambda-dev"
    retention_in_days = 30
    tags = {
      service = "lambda"
}
  }
}

# ─── IAM Role ─────────────────────────────────────────────────────────────────
iam_role_name                  = "belc-affinity-lambda-role-dev"
iam_role_description           = "IAM execution role for Lambda function belc-affinity-lambda-dev"
iam_role_path                  = "/"
iam_role_max_session_duration  = 3600
iam_role_force_detach_policies = false

assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]

managed_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
]

# ─── Security Group ───────────────────────────────────────────────────────────
security_group_name        = "belc-affinity-lambda-dev-sg"
security_group_description = "Security group for Lambda function belc-affinity-lambda-dev"
vpc_id                     = ""

ingress_rules = []

egress_rules = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

default_egress_allow_all = true
revoke_rules_on_delete   = false

# ─── Permission Bridge Variables ──────────────────────────────────────────────
s3_bucket_name_test_crossaccount_opsera_demo = "test-crossaccount-opsera-demo"
secrets_manager_secret_name                  = "affinity-test-secrets"

default_tags = {
  grupo = "affinity"
  service = "lambda"
  environment = "dev"
  managed_by = "cloudforge"
}
