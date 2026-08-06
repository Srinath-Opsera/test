# terraform-aws-lambda

Terraform module to deploy an AWS Lambda function with optional IAM role, CloudWatch log group, VPC networking, alias, function URL, and event source mappings.

## Usage

### Zip deployment (minimal)


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-api-handler"
  environment   = "prod"
  runtime       = "python3.12"
  handler       = "index.handler"
  filename      = "${path.module}/dist/function.zip"
  source_code_hash = filebase64sha256("${path.module}/dist/function.zip")

  environment_variables = {
    LOG_LEVEL = "INFO"
    TABLE_NAME = "my-table"
  }

  tags = {
    Team    = "platform"
    Project = "api"
  }
}


### Container image deployment with VPC


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-container-fn"
  environment   = "prod"
  package_type  = "Image"
  image_uri     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-repo:latest"
  memory_size   = 512
  timeout       = 60

  vpc_subnet_ids = ["subnet-aaa", "subnet-bbb"]
  vpc_id         = "vpc-12345"

  additional_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]

  tags = { Team = "backend" }
}


### With alias and function URL


module "lambda" {
  source = "./modules/lambda"

  function_name = "my-public-fn"
  environment   = "prod"
  publish       = true

  create_alias = true
  alias_name   = "live"

  create_function_url            = true
  function_url_authorization_type = "NONE"

  tags = {}
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `function_name` | Unique name for the Lambda function | `string` | — | yes |
| `environment` | Deployment environment (dev/staging/prod/test/qa) | `string` | — | yes |
| `description` | Description of the Lambda function | `string` | `""` | no |
| `tags` | Map of tags to assign to all resources | `map(string)` | `{}` | no |
| `package_type` | Deployment package type: Zip or Image | `string` | `"Zip"` | no |
| `runtime` | Lambda runtime identifier | `string` | `"python3.12"` | no |
| `handler` | Function entrypoint (file.method) | `string` | `"index.handler"` | no |
| `architecture` | Instruction set: x86_64 or arm64 | `string` | `"x86_64"` | no |
| `filename` | Path to local zip deployment package | `string` | `null` | no |
| `source_code_hash` | Base64 SHA256 hash of the zip package | `string` | `null` | no |
| `s3_bucket` | S3 bucket for deployment package | `string` | `null` | no |
| `s3_key` | S3 key for deployment package | `string` | `null` | no |
| `s3_object_version` | S3 object version for deployment package | `string` | `null` | no |
| `image_uri` | ECR image URI (Image package type) | `string` | `null` | no |
| `image_config` | Container image config map | `map(any)` | `null` | no |
| `timeout` | Max execution time in seconds (1-900) | `number` | `30` | no |
| `memory_size` | Memory in MB (128-10240) | `number` | `128` | no |
| `reserved_concurrent_executions` | Reserved concurrency (-1 to remove) | `number` | `-1` | no |
| `publish` | Publish a new version on each deploy | `bool` | `false` | no |
| `layers` | List of layer ARNs (max 5) | `list(string)` | `[]` | no |
| `environment_variables` | Environment variables map | `map(string)` | `{}` | no |
| `create_iam_role` | Create a new IAM execution role | `bool` | `true` | no |
| `iam_role_name` | Override IAM role name | `string` | `null` | no |
| `iam_role_permissions_boundary` | Permissions boundary ARN for IAM role | `string` | `null` | no |
| `existing_iam_role_arn` | Existing IAM role ARN (create_iam_role=false) | `string` | `null` | no |
| `additional_policy_arns` | Additional IAM policy ARNs to attach | `list(string)` | `[]` | no |
| `inline_policy_json` | JSON inline policy to attach to role | `string` | `null` | no |
| `vpc_id` | VPC ID (required with create_security_group) | `string` | `null` | no |
| `vpc_subnet_ids` | Subnet IDs for VPC config | `list(string)` | `null` | no |
| `vpc_security_group_ids` | Additional security group IDs | `list(string)` | `[]` | no |
| `create_security_group` | Create a dedicated security group | `bool` | `true` | no |
| `security_group_name` | Override security group name | `string` | `null` | no |
| `create_cloudwatch_log_group` | Create CloudWatch log group | `bool` | `true` | no |
| `cloudwatch_logs_retention_days` | Log retention in days | `number` | `14` | no |
| `cloudwatch_logs_kms_key_id` | KMS key ARN for log encryption | `string` | `null` | no |
| `kms_key_arn` | KMS key ARN for env var encryption | `string` | `null` | no |
| `dead_letter_target_arn` | SQS/SNS ARN for dead-letter config | `string` | `null` | no |
| `tracing_mode` | X-Ray tracing mode: PassThrough or Active | `string` | `null` | no |
| `file_system_arn` | EFS access point ARN | `string` | `null` | no |
| `file_system_local_mount_path` | EFS local mount path (must start with /mnt/) | `string` | `null` | no |
| `create_alias` | Create a Lambda alias | `bool` | `false` | no |
| `alias_name` | Name of the Lambda alias | `string` | `"live"` | no |
| `alias_description` | Description of the Lambda alias | `string` | `""` | no |
| `alias_function_version` | Version the alias points to | `string` | `null` | no |
| `create_function_url` | Create a Lambda function URL | `bool` | `false` | no |
| `function_url_authorization_type` | Function URL auth type: NONE or AWS_IAM | `string` | `"AWS_IAM"` | no |
| `function_url_cors` | CORS config map for function URL | `map(any)` | `null` | no |
| `lambda_permissions` | List of Lambda permission objects | `list(map(string))` | `[]` | no |
| `event_source_mappings` | List of event source mapping configs | `list(map(any))` | `[]` | no |
| `snap_start_apply_on` | Snap Start: PublishedVersions or None | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| `function_arn` | ARN of the Lambda function |
| `function_name` | Name of the Lambda function |
| `function_qualified_arn` | Qualified ARN including version |
| `function_version` | Latest published version |
| `function_invoke_arn` | Invoke ARN for API Gateway integration |
| `function_last_modified` | Last modified timestamp |
| `iam_role_arn` | ARN of the IAM execution role |
| `iam_role_name` | Name of the IAM execution role |
| `cloudwatch_log_group_name` | CloudWatch log group name |
| `cloudwatch_log_group_arn` | CloudWatch log group ARN |
| `security_group_id` | Security group ID (VPC only) |
| `alias_arn` | ARN of the Lambda alias |
| `alias_name` | Name of the Lambda alias |
| `alias_invoke_arn` | Invoke ARN of the Lambda alias |
| `function_url` | HTTPS endpoint of the function URL |
| `function_url_id` | Unique ID of the function URL |

## Notes

- When `vpc_subnet_ids` is set, the module automatically attaches `AWSLambdaVPCAccessExecutionRole` instead of `AWSLambdaBasicExecutionRole`.
- Set `create_iam_role = false` and provide `existing_iam_role_arn` to bring your own role.
- `publish = true` is required for `create_alias = true` to work correctly with versioned deployments.
- Function URL with `authorization_type = "NONE"` automatically adds a public resource-based policy.
