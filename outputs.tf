output "vpc_id" {
  description = "ID of the VPC"
  value       = module.terraform-aws-vpc--vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.terraform-aws-vpc--vpc.vpc_cidr_block
}

output "vpc_private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.terraform-aws-vpc--vpc.private_subnet_ids
}

output "vpc_public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.terraform-aws-vpc--vpc.public_subnet_ids
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.terraform-aws-subnet--subnet.subnet_id
}

output "subnet_cidr_block" {
  description = "CIDR block of the subnet"
  value       = module.terraform-aws-subnet--subnet.subnet_cidr_block
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.terraform-aws-security-group--lambda-security-group.security_group_id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = module.terraform-aws-security-group--lambda-security-group.security_group_arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.terraform-aws-iam-role--lambda-execution-iam-role.role_arn
}

output "iam_role_name" {
  description = "Name of the IAM role"
  value       = module.terraform-aws-iam-role--lambda-execution-iam-role.role_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.aws-ecr-repository.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.aws-ecr-repository.repository_arn
}

output "cloudwatch_log_group_names" {
  description = "Map of log group keys to their names"
  value       = module.aws-cloudwatch--cloudwatch-log-group.log_group_names
}

output "cloudwatch_log_group_arns" {
  description = "Map of log group keys to their ARNs"
  value       = module.aws-cloudwatch--cloudwatch-log-group.log_group_arns
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.aws-lambda-function.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.aws-lambda-function.function_arn
}

output "lambda_function_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = module.aws-lambda-function.function_invoke_arn
}

output "lambda_iam_role_arn" {
  description = "ARN of the Lambda IAM execution role"
  value       = module.aws-lambda-function.iam_role_arn
}

output "lambda_iam_role_name" {
  description = "Name of the Lambda IAM execution role"
  value       = module.aws-lambda-function.iam_role_name
}

output "lambda_cloudwatch_log_group_name" {
  description = "Name of the Lambda CloudWatch log group"
  value       = module.aws-lambda-function.cloudwatch_log_group_name
}

output "cross_account_s3_policy_arn" {
  description = "ARN of the cross-account S3 access policy"
  value       = aws_iam_policy.cross_account_s3_test_crossaccount_opsera_demo_access.arn
}
