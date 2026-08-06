output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc--vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.vpc--vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "Private subnet IDs from VPC module"
  value       = module.vpc--vpc.private_subnet_ids
}

output "private_subnet_1_id" {
  description = "Private subnet 1 ID"
  value       = module.subnet--private-subnet.subnet_id
}

output "private_subnet_2_id" {
  description = "Private subnet 2 ID"
  value       = module.subnet--db-subnet-group.subnet_id
}

output "db_subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.opsera_test.name
}

output "lambda_sg_id" {
  description = "Lambda security group ID"
  value       = module.security-group--lambda-security-group.security_group_id
}

output "rds_sg_id" {
  description = "RDS security group ID"
  value       = module.security-group--aurora-postgresql-rds-security-group.security_group_id
}

output "s3_bucket_id" {
  description = "S3 bucket name"
  value       = module.s3--s3-bucket.bucket_id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3--s3-bucket.bucket_arn
}

output "lambda_log_group_names" {
  description = "CloudWatch log group names"
  value       = module.cloudwatch--cloudwatch-log-group-lambda.log_group_names
}

output "lambda_log_group_arns" {
  description = "CloudWatch log group ARNs"
  value       = module.cloudwatch--cloudwatch-log-group-lambda.log_group_arns
}

output "secret_arn" {
  description = "Secrets Manager secret ARN"
  value       = module.aws-secrets-manager-secret.secret_arn
}

output "secret_name" {
  description = "Secrets Manager secret name"
  value       = module.aws-secrets-manager-secret.secret_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = module.lambda--lambda-function.function_arn
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = module.lambda--lambda-function.function_name
}

output "lambda_role_arn" {
  description = "Lambda execution role ARN"
  value       = module.lambda--lambda-function.role_arn
}

output "rds_instance_id" {
  description = "RDS instance ID"
  value       = module.rds--aurora-postgresql-rds.db_instance_id
}

output "rds_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds--aurora-postgresql-rds.db_instance_endpoint
}

output "rds_instance_arn" {
  description = "RDS instance ARN"
  value       = module.rds--aurora-postgresql-rds.db_instance_arn
}
