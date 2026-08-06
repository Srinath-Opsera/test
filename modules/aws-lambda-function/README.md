# Terraform AWS Lambda Module

This module creates an AWS Lambda function with supporting resources including IAM roles, CloudWatch log groups, VPC configuration, security groups, aliases, function URLs, permissions, and event source mappings.

## Usage


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-api-handler"
  environment   = "prod"
  description   = "Handles API requests"

  # Zip deployment from S3
  package_type = "Zip"
  runtime      = "python3.12"
  handler      = "app.handler"
  s3_bucket    = "my-deployment-bucket"
  s3_key       = "functions/my-api-handler.zip"

  memory_size = 256
  timeout     = 60

  environment_variables = {
    LOG_LEVEL = "INFO"
    TABLE_NAME = "my-table"
  }

  # VPC
  vpc_subnet_ids        = ["subnet-abc", "subnet-def"]
  vpc_id                = "vpc-12345"
  create_security_group = true

  # Observability
  tracing_mode          = "Active"
  log_retention_in_days = 30

  # Dead letter queue
  dead_letter_target_arn = aws_sqs_queue.dlq.arn

  # Additional IAM permissions
  additional_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]

  tags = {
    Team    = "platform"
    Project = "api"
  }
}


### Container Image


module "lambda_image" {
  source = "./modules/lambda"

  function_name = "my-container-fn"
  environment   = "prod"
  package_type  = "Image"
  image_uri     = "123456789.dkr.ecr.us-east-1.amazonaws.com/my-fn:latest"

  tags = {}
}


### With Function URL


module "lambda_url" {
  source = "./modules/lambda"

  function_name                  = "my-public-fn"
  environment                    = "dev"
  runtime                        = "nodejs20.x"
  handler                        = "index.handler"
  filename                       = "function.zip"
  create_function_url            = true
  function_url_authorization_type = "NONE"

  tags = {}
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `function_name` | Name of the Lambda function | `string` | — | yes |
| `environment` | Deployment environment | `string` | — | yes |
| `description` | Description of the Lambda function | `string` | `""` | no |
| `tags` | Map of tags to assign to resources | `map(string)` | `{}` | no |
| `package_type` | Deployment package type: Zip or Image | `string` | `"Zip"` | no |
| `filename` | Path to local zip file | `string` | `null` | no |
| `s3_bucket` | S3 bucket for deployment package | `string` | `null` | no |
| `s3_key` | S3 key for deployment package | `string` | `null` | no |
| `image_uri` | ECR image URI (Image package type) | `string` | `null` | no |
| `runtime` | Lambda runtime identifier | `string` | `null` | no |
| `handler` | Function entrypoint | `string` | `null` | no |
| `architecture` | Instruction set: x86_64 or arm64 | `string` | `"x86_64"` | no |
| `memory_size` | Memory in MB (128–10240) | `number` | `128` | no |
| `timeout` | Timeout in seconds (1–900) | `number` | `30` | no |
| `reserved_concurrent_executions` | Reserved concurrency (-1 = unlimited) | `number` | `-1` | no |
| `layers` | List of layer ARNs (max 5) | `list(string)` | `[]` | no |
| `publish` | Publish a new version on each update | `bool` | `false` | no |
| `environment_variables` | Environment variables map | `map(string)` | `{}` | no |
| `ephemeral_storage_size` | /tmp size in MB (512–10240) | `number` | `null` | no |
| `create_iam_role` | Create an IAM execution role | `bool` | `true` | no |
| `iam_role_name` | Custom IAM role name | `string` | `null` | no |
| `existing_iam_role_arn` | Existing IAM role ARN | `string` | `null` | no |
| `additional_policy_arns` | Additional policy ARNs to attach | `list(string)` | `[]` | no |
| `inline_policy_json` | Inline IAM policy JSON | `string` | `null` | no |
| `vpc_subnet_ids` | Subnet IDs for VPC deployment | `list(string)` | `null` | no |
| `vpc_id` | VPC ID for security group | `string` | `null` | no |
| `vpc_security_group_ids` | Existing security group IDs | `list(string)` | `[]` | no |
| `create_security_group` | Create a security group | `bool` | `false` | no |
| `create_cloudwatch_log_group` | Create a CloudWatch log group | `bool` | `true` | no |
| `log_retention_in_days` | Log retention in days | `number` | `14` | no |
| `log_kms_key_id` | KMS key for log encryption | `string` | `null` | no |
| `tracing_mode` | X-Ray tracing: PassThrough or Active | `string` | `null` | no |
| `dead_letter_target_arn` | SQS/SNS ARN for dead letter queue | `string` | `null` | no |
| `aliases` | Map of Lambda aliases to create | `map(object)` | `{}` | no |
| `create_function_url` | Create a Lambda function URL | `bool` | `false` | no |
| `function_url_authorization_type` | Function URL auth: NONE or AWS_IAM | `string` | `"AWS_IAM"` | no |
| `lambda_permissions` | Map of Lambda permission statements | `map(object)` | `{}` | no |
| `event_source_mappings` | Map of event source mappings | `map(object)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `function_name` | Lambda function name |
| `function_arn` | Lambda function ARN |
| `function_qualified_arn` | Qualified ARN (with version) |
| `function_invoke_arn` | Invoke ARN for API Gateway |
| `function_version` | Latest published version |
| `iam_role_arn` | IAM execution role ARN |
| `iam_role_name` | IAM execution role name |
| `cloudwatch_log_group_name` | CloudWatch log group name |
| `cloudwatch_log_group_arn` | CloudWatch log group ARN |
| `security_group_id` | Security group ID (VPC only) |
| `alias_arns` | Map of alias names to ARNs |
| `alias_invoke_arns` | Map of alias names to invoke ARNs |
| `function_url` | Lambda function HTTPS URL |
| `event_source_mapping_ids` | Map of event source mapping UUIDs |
