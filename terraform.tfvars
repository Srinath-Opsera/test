region = "us-east-1"

# ── IAM Role ──────────────────────────────────────────────────────────────────
iam_role_name        = "belc-affinity-test-lambda-role-dev"
iam_role_description = "IAM execution role for Lambda function affinity-test"

assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]

managed_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
]

# ── Secrets Manager ───────────────────────────────────────────────────────────
secret_name        = "affinity-affinity-test-dev"
secret_description = "Secrets for Lambda function affinity-test including API token and database passwords"
recovery_window_in_days = 7

secret_string = ""

default_tags = {
  grupo = "affinity"
  service = "affinity-test"
  environment = "dev"
  managed_by = "cloudforge"
}
