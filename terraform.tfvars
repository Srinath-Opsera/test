region       = "us-east-1"
service_name = "affinity-test"
team         = "platform"
environment  = "dev"

assume_role_arn_acct_792373136340         = ""
assume_role_external_id_acct_792373136340 = ""

log_groups = {
  "affinity-test" = {
    name              = "/aws/lambda/affinity-test"
    retention_in_days = 30
  }
}

cloudwatch_tags = {
  Name = "/aws/lambda/affinity-test"
}

name = "affinity-test-lambda-exec-role"

assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]

description          = ""
path                 = "/"
max_session_duration = 3600

managed_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
  "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
]

force_detach_policies = false

iam_role_tags = {
  Name = "affinity-test-lambda-exec-role"
}

security_group_name        = "lambda-affinity-test"
vpc_id                     = ""
security_group_description = "Security group for affinity-test Lambda function"

ingress_rules = []

egress_rules = [
  {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
]

default_egress_allow_all = true
revoke_rules_on_delete   = false

security_group_tags = {
  Name = "lambda-affinity-test"
}

repository_name      = "affinity-test"
image_tag_mutability = "MUTABLE"
scan_on_push         = true
encryption_type      = "AES256"
ecr_kms_key_arn      = null
force_delete         = false
lifecycle_policy     = null
repository_policy    = null
replication_destinations = []
replication_filters      = []

ecr_tags = {
  Name = "affinity-test"
}

function_name         = "affinity-test"
lambda_description    = ""
runtime               = "nodejs20.x"
handler               = null
architecture          = "x86_64"
image_uri             = null
timeout               = 30
memory_size           = 128
publish               = true
environment_variables = {}
layer_arns            = []
create_iam_role       = false
vpc_subnet_ids        = null
log_retention_in_days = 30

lambda_tags = {
  Name      = "affinity-test"
  Plataforma = "Lambda"
}

secret_name                       = "affinity-test-secrets"
recovery_window_in_days           = 30
force_overwrite_replica_secret    = false
enable_rotation                   = false
rotation_automatically_after_days = 30
block_public_policy               = true

secret_key_value_pairs = {
  AFFINITY_API_TOKEN = ""
  PGPASSWORD_QAS     = ""
  PGPASSWORD_DEV     = ""
}

secrets_tags = {
  Name = "affinity-test-secrets"
}

cross_account_s3_bucket_name = "test-crossaccount-opsera-demo"

default_tags = {
  Grupo = "platform"
  Entorno = "dev"
  Owner = "platform"
  Contacto = "platform"
  Terraform = "true"
  ManagedBy = "Opsera"
  Service = "affinity-test"
  NewRelic = "true"
}
