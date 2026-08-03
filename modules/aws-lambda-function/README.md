# terraform-aws-lambda

Terraform module for deploying an AWS Lambda function with optional IAM role, CloudWatch log group, VPC networking, aliases, function URLs, and event source mappings.

## Features

- Lambda function with Zip or container image (`Image`) deployment
- Auto-created IAM execution role with optional inline/managed policy attachments
- CloudWatch log group with configurable retention
- VPC support with auto-created security group
- Lambda alias and versioning
- Lambda function URL with optional CORS
- Trigger permissions (`aws_lambda_permission`)
- Event source mappings (SQS, DynamoDB, Kinesis, etc.)
- X-Ray tracing, KMS encryption, EFS mount, SnapStart, dead-letter queue

## Usage

### Basic (S3 deployment)

hcl
module "lambda" {
  source = "./modules/lambda"

  function_name = "my-api-handler"
  environment   = "prod"
  runtime       = "python3.12"
  handler       = "app.handler"
  s3_bucket     = "my-deployment-bucket"
  s3_key        = "functions/my-api-handler.zip"

  memory_size = 256
  timeout     = 60

  environment_variables = {
    LOG_LEVEL = "INFO"
    TABLE_NAME = "my-table"
  }

  tags = {
    Team    = "platform"
    Project = "api"
  }
}


### VPC-connected with SQS trigger

hcl
module "lambda" {
  source = "./modules/lambda"

  function_name   = "sqs-processor"
  environment     = "prod"
  runtime         = "nodejs20.x"
  handler         = "index.handler"
  filename        = "${path.module}/dist/function.zip"
  source_code_hash = filebase64sha256("${path.module}/dist/function.zip")

  vpc_subnet_ids = ["subnet-aaa", "subnet-bbb"]
  vpc_id         = "vpc-12345"

  event_source_mappings = {
    sqs = {
      event_source_arn                   = aws_sqs_queue.this.arn
      batch_size                         = 10
      maximum_batching_window_in_seconds = 5
      function_response_types            = ["ReportBatchItemFailures"]
    }
  }

  additional_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess"
  ]

  tags = { Team = "data" }
}


### Container image with function URL

hcl
module "lambda" {
  source = "./modules/lambda"

  function_name = "container-api"
  environment   = "staging"
  package_type  = "Image"
  image_uri     = "123456789.dkr.ecr.us-east-1.amazonaws.com/my-app:latest"

  create_function_url            = true
  function_url_authorization_type = "NONE"

  function_url_cors = {
    allow_origins = ["https://example.com"]
    allow_methods = ["GET", "POST"]
    allow_headers = ["Content-Type"]
    max_age       = 86400
  }

  tags = { Team = "frontend" }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `function_name` | Unique name for the Lambda function | `string` | — | yes |
| `environment` | Deployment environment (dev/staging/prod/test/qa) | `string` | — | yes |
| `tags` | Map of tags to assign to all resources | `map(string)` | `{}` | no |
| `description` | Description of the Lambda function | `string` | `""` | no |
| `runtime` | Lambda runtime identifier | `string` | `null` | no |
| `handler` | Function entrypoint | `string` | `null` | no |
| `architecture` | Instruction set architecture (x86_64, arm64) | `string` | `"x86_64"` | no |
| `package_type` | Deployment package type (Zip, Image) | `string` | `"Zip"` | no |
| `filename` | Path to local .zip deployment package | `string` | `null` | no |
| `source_code_hash` | Base64 SHA256 hash of deployment package | `string` | `null` | no |
| `s3_bucket` | S3 bucket for deployment package | `string` | `null` | no |
| `s3_key` | S3 key for deployment package | `string` | `null` | no |
| `s3_object_version` | S3 object version for deployment package | `string` | `null` | no |
| `image_uri` | ECR image URI for container deployments | `string` | `null` | no |
| `timeout` | Max execution time in seconds (1-900) | `number` | `30` | no |
| `memory_size` | Memory in MB (128-10240) | `number` | `128` | no |
| `reserved_concurrent_executions` | Reserved concurrency (-1 to disable) | `number` | `null` | no |
| `ephemeral_storage_size` | /tmp size in MB (512-10240) | `number` | `null` | no |
| `environment_variables` | Map of environment variables | `map(string)` | `{}` | no |
| `layer_arns` | List of Lambda layer ARNs (max 5) | `list(string)` | `[]` | no |
| `create_iam_role` | Create IAM execution role | `bool` | `true` | no |
| `iam_role_name` | Override IAM role name | `string` | `null` | no |
| `existing_role_arn` | Existing IAM role ARN (when create_iam_role=false) | `string` | `null` | no |
| `permissions_boundary_arn` | IAM permissions boundary ARN | `string` | `null` | no |
| `additional_policy_arns` | Additional IAM policy ARNs to attach | `list(string)` | `[]` | no |
| `inline_policy_json` | Inline IAM policy JSON | `string` | `null` | no |
| `vpc_subnet_ids` | Subnet IDs for VPC deployment | `list(string)` | `null` | no |
| `vpc_id` | VPC ID for security group | `string` | `null` | no |
| `vpc_security_group_ids` | Additional security group IDs | `list(string)` | `[]` | no |
| `create_security_group` | Create dedicated security group | `bool` | `true` | no |
| `security_group_name` | Override security group name | `string` | `null` | no |
| `create_cloudwatch_log_group` | Create CloudWatch log group | `bool` | `true` | no |
| `log_retention_in_days` | Log retention in days | `number` | `14` | no |
| `log_kms_key_id` | KMS key ARN for log group encryption | `string` | `null` | no |
| `kms_key_arn` | KMS key ARN for environment variable encryption | `string` | `null` | no |
| `tracing_mode` | X-Ray tracing mode (PassThrough, Active) | `string` | `null` | no |
| `dead_letter_target_arn` | SQS/SNS ARN for dead letter queue | `string` | `null` | no |
| `file_system_arn` | EFS access point ARN | `string` | `null` | no |
| `file_system_local_mount_path` | EFS local mount path (must start with /mnt/) | `string` | `null` | no |
| `publish` | Publish new version on each deploy | `bool` | `false` | no |
| `create_alias` | Create Lambda alias | `bool` | `false` | no |
| `alias_name` | Lambda alias name | `string` | `"live"` | no |
| `alias_description` | Lambda alias description | `string` | `""` | no |
| `alias_function_version` | Version the alias points to | `string` | `null` | no |
| `snap_start_enabled` | Enable SnapStart (Java runtimes) | `bool` | `false` | no |
| `create_function_url` | Create Lambda function URL | `bool` | `false` | no |
| `function_url_authorization_type` | Function URL auth type (NONE, AWS_IAM) | `string` | `"AWS_IAM"` | no |
| `function_url_cors` | CORS configuration for function URL | `any` | `null` | no |
| `allowed_triggers` | Map of Lambda permission configurations | `map(any)` | `{}` | no |
| `event_source_mappings` | Map of event source mapping configurations | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `function_name` | Lambda function name |
| `function_arn` | Lambda function ARN |
| `function_qualified_arn` | Lambda function qualified ARN (with version) |
| `function_invoke_arn` | Lambda function invoke ARN (for API Gateway) |
| `function_version` | Latest published version |
| `function_last_modified` | Last modified timestamp |
| `role_arn` | IAM execution role ARN |
| `role_name` | IAM execution role name |
| `log_group_name` | CloudWatch log group name |
| `log_group_arn` | CloudWatch log group ARN |
| `security_group_id` | Security group ID (VPC only) |
| `alias_arn` | Lambda alias ARN |
| `alias_invoke_arn` | Lambda alias invoke ARN |
| `function_url` | Lambda function URL endpoint |
| `function_url_id` | Lambda function URL unique identifier |
