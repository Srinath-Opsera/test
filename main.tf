# ============================================================
# CloudWatch Log Group
# ============================================================
module "cloudwatch" {
  source = "./modules/aws-cloudwatch"

  log_groups = var.log_groups

  tags = var.cloudwatch_tags
}

# ============================================================
# Lambda Execution IAM Role
# ============================================================
module "lambda_execution_role" {
  source = "./modules/terraform-aws-iam-role"

  name        = var.lambda_role_name
  description = var.lambda_role_description
  path        = "/"

  assume_role_principals = var.lambda_assume_role_principals

  managed_policy_arns   = var.lambda_managed_policy_arns
  force_detach_policies = var.lambda_force_detach_policies
  max_session_duration  = var.lambda_max_session_duration

  inline_policies = {
    "s3-crossaccount-access" = {
      name   = "s3-crossaccount-access"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Sid    = "CrossAccountS3Access"
            Effect = "Allow"
            Action = [
              "s3:GetObject",
              "s3:PutObject",
              "s3:DeleteObject",
              "s3:ListBucket",
              "s3:GetBucketLocation"
            ]
            Resource = [
              "arn:aws:s3:::${var.crossaccount_s3_bucket_name}",
              "arn:aws:s3:::${var.crossaccount_s3_bucket_name}/*"
            ]
          }
        ]
      })
    }
  }

  tags = var.lambda_role_tags
}

# ============================================================
# Lambda Security Group
# ============================================================
module "lambda_security_group" {
  source = "./modules/terraform-aws-security-group"

  name        = var.lambda_sg_name
  description = var.lambda_sg_description
  vpc_id      = var.vpc_id

  ingress_rules = []

  egress_rules = var.lambda_sg_egress_rules

  default_egress_allow_all = false
  revoke_rules_on_delete   = false

  tags = var.lambda_sg_tags
}


# --- Resource Policies (auto-generated, preserving existing statements) ---

resource "aws_s3_bucket_policy" "existing_s3_bucket_test_crossaccount_opsera_demo_policy" {
  provider = aws.acct_792373136340
  bucket = var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name

  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "ExistingLegacyAccess",
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::792373136340:root"
          },
          "Action": [
            "s3:GetObject",
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::test-crossaccount-opsera-demo",
            "arn:aws:s3:::test-crossaccount-opsera-demo/*"
          ]
        },
        {
          "Sid": "Allowlambda_execution_iam_roleObjectAccess",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${module.lambda_execution_role.role_arn}"
          },
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name}/*"
        },
        {
          "Sid": "Allowlambda_execution_iam_roleListBucket",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${module.lambda_execution_role.role_arn}"
          },
          "Action": [
            "s3:ListBucket"
          ],
          "Resource": "arn:aws:s3:::${var.existing_s3_bucket_test_crossaccount_opsera_demo_bucket_name}"
        }
      ]
    })
  depends_on = [module.lambda_execution_role]
}
