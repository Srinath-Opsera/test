# Lambda Function Module

This Terraform module creates an AWS Lambda function with optional supporting resources including IAM roles, CloudWatch log groups, VPC networking, aliases, function URLs, event source mappings, and auto-scaling for provisioned concurrency.

## Usage

### Basic (S3 deployment package)


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-api-handler"
  environment   = "prod"
  runtime       = "python3.12"
  handler       = "app.handler"
  s3_bucket     = "my-deployment-bucket"
  s3_key        = "functions/my-api-handler.zip"

  environment_variables = {
    LOG_LEVEL = "INFO"
    DB_HOST   = "db.example.com"
  }

  tags = {
    Team    = "platform"
    Project = "api"
  }
}


### VPC-enabled with alias and function URL


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-vpc-function"
  environment   = "prod"
  runtime       = "nodejs20.x"
  handler       = "index.handler"
  filename      = "${path.module}/dist/function.zip"
  source_code_hash = filebase64sha256("${path.module}/dist/function.zip")

  memory_size = 512
  timeout     = 60

  vpc_id         = "vpc-0abc123"
  vpc_subnet_ids = ["subnet-0abc123", "subnet-0def456"]

  create_alias = true
  alias_name   = "live"
  publish      = true

  create_function_url            = true
  function_url_authorization_type = "AWS_IAM"

  additional_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]

  tags = {
    Team = "backend"
  }
}


### Container image deployment


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-container-function"
  environment   = "staging"
  image_uri     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-function:latest"

  memory_size = 1024
  timeout     = 120
  architecture = "arm64"

  tags = {}
}


## Resources Created

| Resource | Condition |
|---|---|
| `aws_lambda_function` | Always |
| `aws_iam_role` | `create_iam_role = true` (default) |
| `aws_iam_role_policy_attachment` | `create_iam_role = true` |
| `aws_iam_role_policy` | `create_iam_role = true` and `inline_policy_json` set |
| `aws_cloudwatch_log_group` | `create_cloudwatch_log_group = true` (default) |
| `aws_security_group` | `create_security_group = true` and `vpc_subnet_ids` set |
| `aws_lambda_alias` | `create_alias = true` |
| `aws_lambda_function_url` | `create_function_url = true` |
| `aws_lambda_permission` | Per entry in `lambda_permissions` |
| `aws_lambda_event_source_mapping` | Per entry in `event_source_mappings` |
| `aws_appautoscaling_target` | `create_alias = true` and `provisioned_concurrency_config` set |

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `function_name` | `string` | required | Name of the Lambda function |
| `environment` | `string` | required | Deployment environment (dev/staging/prod/test/qa) |
| `description` | `string` | `""` | Description of the function |
| `tags` | `map(string)` | `{}` | Tags to apply to all resources |
| `runtime` | `string` | `null` | Lambda runtime identifier |
| `handler` | `string` | `null` | Function entrypoint |
| `architecture` | `string` | `"x86_64"` | x86_64 or arm64 |
| `s3_bucket` | `string` | `null` | S3 bucket for deployment package |
| `s3_key` | `string` | `null` | S3 key for deployment package |
| `s3_object_version` | `string` | `null` | S3 object version |
| `filename` | `string` | `null` | Local zip file path |
| `source_code_hash` | `string` | `null` | Hash of deployment package |
| `image_uri` | `string` | `null` | ECR image URI for container deployments |
| `timeout` | `number` | `30` | Function timeout in seconds (1-900) |
| `memory_size` | `number` | `128` | Memory in MB (128-10240, multiples of 64) |
| `reserved_concurrent_executions` | `number` | `null` | Reserved concurrency limit |
| `ephemeral_storage_size` | `number` | `null` | /tmp size in MB (512-10240) |
| `publish` | `bool` | `false` | Publish a new version on deploy |
| `snap_start_enabled` | `bool` | `false` | Enable SnapStart (Java only) |
| `environment_variables` | `map(string)` | `{}` | Environment variables |
| `layer_arns` | `list(string)` | `[]` | Lambda layer ARNs (max 5) |
| `create_iam_role` | `bool` | `true` | Create IAM execution role |
| `iam_role_name` | `string` | `null` | Custom IAM role name |
| `existing_role_arn` | `string` | `null` | Existing role ARN (when create_iam_role=false) |
| `additional_policy_arns` | `list(string)` | `[]` | Additional policy ARNs to attach |
| `inline_policy_json` | `string` | `null` | Inline IAM policy JSON |
| `vpc_id` | `string` | `null` | VPC ID for VPC deployment |
| `vpc_subnet_ids` | `list(string)` | `null` | Subnet IDs for VPC deployment |
| `vpc_security_group_ids` | `list(string)` | `[]` | Existing security group IDs |
| `create_security_group` | `bool` | `true` | Create a security group for VPC |
| `security_group_name` | `string` | `null` | Custom security group name |
| `create_cloudwatch_log_group` | `bool` | `true` | Create CloudWatch log group |
| `log_retention_in_days` | `number` | `14` | Log retention period |
| `kms_key_arn` | `string` | `null` | KMS key ARN for encryption |
| `dead_letter_target_arn` | `string` | `null` | DLQ SQS/SNS ARN |
| `tracing_mode` | `string` | `null` | X-Ray tracing mode |
| `file_system_arn` | `string` | `null` | EFS access point ARN |
| `file_system_local_mount_path` | `string` | `null` | EFS mount path (must start with /mnt/) |
| `create_alias` | `bool` | `false` | Create a Lambda alias |
| `alias_name` | `string` | `"live"` | Alias name |
| `alias_description` | `string` | `""` | Alias description |
| `alias_function_version` | `string` | `null` | Version the alias points to |
| `create_function_url` | `bool` | `false` | Create a function URL |
| `function_url_authorization_type` | `string` | `"AWS_IAM"` | Function URL auth type |
| `function_url_cors` | `map(any)` | `null` | Function URL CORS config |
| `lambda_permissions` | `map(map(string))` | `{}` | Lambda resource-based permissions |
| `event_source_mappings` | `any` | `{}` | Event source mapping configurations |
| `provisioned_concurrency_config` | `map(number)` | `null` | Auto-scaling for provisioned concurrency |

## Outputs

| Name | Description |
|---|---|
| `function_arn` | Lambda function ARN |
| `function_name` | Lambda function name |
| `function_qualified_arn` | Qualified ARN including version |
| `function_version` | Latest published version |
| `function_invoke_arn` | Invoke ARN for API Gateway |
| `function_last_modified` | Last modified timestamp |
| `alias_arn` | Alias ARN (if created) |
| `alias_invoke_arn` | Alias invoke ARN (if created) |
| `function_url` | Function URL HTTPS endpoint (if created) |
| `function_url_id` | Function URL unique ID (if created) |
| `iam_role_arn` | IAM role ARN (if created) |
| `iam_role_name` | IAM role name (if created) |
| `security_group_id` | Security group ID (if created) |
| `cloudwatch_log_group_name` | Log group name (if created) |
| `cloudwatch_log_group_arn` | Log group ARN (if created) |
