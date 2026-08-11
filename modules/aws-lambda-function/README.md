# Lambda Function Module

Provisions an AWS Lambda function with optional IAM role, CloudWatch log group, alias, function URL, and resource-based permissions.

## Features

- Lambda function supporting Zip (S3 or local file) and container Image deployment
- Auto-created IAM execution role with optional additional policies and inline policy
- CloudWatch log group with configurable retention
- Optional Lambda alias with provisioned concurrency
- Optional Lambda function URL (with CORS and public/IAM auth)
- Resource-based permissions for triggers (API Gateway, SNS, S3, EventBridge, etc.)
- VPC support with automatic VPC execution policy attachment
- EFS mount support
- X-Ray tracing, dead-letter queue, SnapStart, and ephemeral storage configuration

## Usage


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-api-handler"
  description   = "Handles API Gateway requests"
  runtime       = "python3.12"
  handler       = "app.handler"
  architecture  = "arm64"

  s3_bucket        = "my-deployment-bucket"
  s3_key           = "functions/my-api-handler.zip"
  source_code_hash = data.aws_s3_object.package_hash.body

  timeout     = 30
  memory_size = 256

  environment_variables = {
    LOG_LEVEL = "INFO"
    TABLE_NAME = aws_dynamodb_table.main.name
  }

  tracing_mode = "Active"

  log_retention_in_days = 30

  create_alias = true
  alias_name   = "live"
  publish      = true

  additional_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]

  allowed_triggers = {
    APIGateway = {
      principal  = "apigateway.amazonaws.com"
      source_arn = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
    }
  }

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `function_name` | `string` | — | Unique name for the Lambda function |
| `description` | `string` | `""` | Description of the function |
| `runtime` | `string` | `null` | Runtime identifier (e.g. `python3.12`) |
| `handler` | `string` | `null` | Function entrypoint (e.g. `index.handler`) |
| `architecture` | `string` | `x86_64` | `x86_64` or `arm64` |
| `package_type` | `string` | `Zip` | `Zip` or `Image` |
| `filename` | `string` | `null` | Local zip file path |
| `source_code_hash` | `string` | `null` | SHA256 hash of deployment package |
| `s3_bucket` | `string` | `null` | S3 bucket for deployment package |
| `s3_key` | `string` | `null` | S3 key for deployment package |
| `s3_object_version` | `string` | `null` | S3 object version |
| `image_uri` | `string` | `null` | ECR image URI for container deployments |
| `timeout` | `number` | `30` | Max execution time in seconds (1-900) |
| `memory_size` | `number` | `128` | Memory in MB (128-10240) |
| `ephemeral_storage_size` | `number` | `null` | /tmp size in MB (512-10240) |
| `reserved_concurrent_executions` | `number` | `-1` | Reserved concurrency (-1 = unreserved) |
| `publish` | `bool` | `false` | Publish a new version on deploy |
| `environment_variables` | `map(string)` | `{}` | Environment variables |
| `layer_arns` | `list(string)` | `[]` | Lambda layer ARNs (max 5) |
| `kms_key_arn` | `string` | `null` | KMS key for env var encryption |
| `tracing_mode` | `string` | `null` | X-Ray tracing: `PassThrough` or `Active` |
| `dead_letter_target_arn` | `string` | `null` | SNS/SQS ARN for dead-letter queue |
| `snap_start_enabled` | `bool` | `false` | Enable SnapStart (Java runtimes) |
| `vpc_subnet_ids` | `list(string)` | `null` | VPC subnet IDs |
| `vpc_security_group_ids` | `list(string)` | `null` | VPC security group IDs |
| `file_system_arn` | `string` | `null` | EFS access point ARN |
| `file_system_local_mount_path` | `string` | `null` | EFS mount path (must start with /mnt/) |
| `create_iam_role` | `bool` | `true` | Create IAM execution role |
| `existing_role_arn` | `string` | `null` | Existing role ARN (when create_iam_role=false) |
| `role_permissions_boundary_arn` | `string` | `null` | Permissions boundary ARN |
| `additional_policy_arns` | `list(string)` | `[]` | Additional policy ARNs to attach |
| `inline_policy_json` | `string` | `null` | Inline IAM policy JSON |
| `create_cloudwatch_log_group` | `bool` | `true` | Create CloudWatch log group |
| `log_retention_in_days` | `number` | `14` | Log retention period |
| `log_kms_key_id` | `string` | `null` | KMS key for log group encryption |
| `create_alias` | `bool` | `false` | Create Lambda alias |
| `alias_name` | `string` | `live` | Alias name |
| `alias_description` | `string` | `""` | Alias description |
| `alias_function_version` | `string` | `null` | Version alias points to |
| `provisioned_concurrent_executions` | `number` | `null` | Provisioned concurrency (requires alias) |
| `create_function_url` | `bool` | `false` | Create function URL |
| `function_url_authorization_type` | `string` | `AWS_IAM` | `NONE` or `AWS_IAM` |
| `function_url_cors` | `any` | `null` | CORS configuration map |
| `allowed_triggers` | `map(any)` | `{}` | Resource-based permission configurations |
| `tags` | `map(string)` | `{}` | Tags to apply to all resources |

## Outputs

| Name | Description |
|------|-------------|
| `function_name` | Lambda function name |
| `function_arn` | Lambda function ARN |
| `function_qualified_arn` | Qualified ARN (with version) |
| `function_version` | Latest published version |
| `function_invoke_arn` | Invoke ARN for API Gateway |
| `function_last_modified` | Last modified timestamp |
| `role_arn` | IAM execution role ARN |
| `role_name` | IAM execution role name |
| `cloudwatch_log_group_name` | CloudWatch log group name |
| `cloudwatch_log_group_arn` | CloudWatch log group ARN |
| `alias_arn` | Lambda alias ARN |
| `alias_name` | Lambda alias name |
| `alias_invoke_arn` | Alias invoke ARN for API Gateway |
| `function_url` | Function URL HTTPS endpoint |
| `function_url_id` | Function URL unique ID |
