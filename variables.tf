variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags applied to all AWS resources via provider default_tags"
  default     = {}
}

# VPC
variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks for VPC module"
}

variable "enable_dns_support" {
  type        = bool
  description = "VPC DNS support"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "VPC DNS hostnames"
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch for public subnets"
  default     = true
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "Single NAT gateway"
  default     = true
}

# Private Subnets
variable "private_subnet_name" {
  type        = string
  description = "Private subnet name prefix"
}

variable "private_subnet_cidr_1" {
  type        = string
  description = "Private subnet 1 CIDR block"
}

variable "private_subnet_az_1" {
  type        = string
  description = "Private subnet 1 availability zone"
}

variable "private_subnet_cidr_2" {
  type        = string
  description = "Private subnet 2 CIDR block"
}

variable "private_subnet_az_2" {
  type        = string
  description = "Private subnet 2 availability zone"
}

# DB Subnet Group
variable "db_subnet_group_name" {
  type        = string
  description = "DB subnet group name"
}

# Security Groups
variable "lambda_sg_name" {
  type        = string
  description = "Lambda security group name"
}

variable "lambda_sg_description" {
  type        = string
  description = "Lambda security group description"
}

variable "rds_sg_name" {
  type        = string
  description = "RDS security group name"
}

variable "rds_sg_description" {
  type        = string
  description = "RDS security group description"
}

# S3
variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "versioning_enabled" {
  type        = bool
  description = "S3 versioning enabled"
  default     = true
}

variable "sse_algorithm" {
  type        = string
  description = "S3 SSE algorithm"
  default     = "AES256"
}

variable "block_public_acls" {
  type        = bool
  description = "S3 block public ACLs"
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "S3 block public policy"
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "S3 ignore public ACLs"
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "S3 restrict public buckets"
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "S3 force destroy"
  default     = false
}

# CloudWatch
variable "lambda_log_group_name" {
  type        = string
  description = "Lambda CloudWatch log group name"
}

variable "lambda_log_retention_days" {
  type        = number
  description = "Lambda log retention in days"
  default     = 30
}

# Secrets Manager
variable "secret_name" {
  type        = string
  description = "Secrets Manager secret name"
}

variable "secret_description" {
  type        = string
  description = "Secrets Manager secret description"
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Secrets Manager recovery window in days"
  default     = 30
}

variable "secret_string" {
  type        = string
  description = "Secrets Manager secret string value"
  sensitive   = true
  default     = null
}

# Lambda
variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime"
}

variable "lambda_handler" {
  type        = string
  description = "Lambda handler"
}

variable "lambda_package_type" {
  type        = string
  description = "Lambda package type"
  default     = "Zip"
}

variable "lambda_filename" {
  type        = string
  description = "Lambda deployment package filename"
  default     = null
}

variable "lambda_memory_size" {
  type        = number
  description = "Lambda memory size in MB"
  default     = 128
}

variable "lambda_timeout" {
  type        = number
  description = "Lambda timeout in seconds"
  default     = 30
}

variable "lambda_reserved_concurrent_executions" {
  type        = number
  description = "Lambda reserved concurrent executions"
  default     = -1
}

variable "lambda_architectures" {
  type        = list(string)
  description = "Lambda architectures"
  default     = ["x86_64"]
}

variable "lambda_environment_variables" {
  type        = map(string)
  description = "Lambda environment variables"
  default     = {}
}

variable "lambda_additional_policy_arns" {
  type        = list(string)
  description = "Lambda additional policy ARNs"
  default     = []
}

# RDS
variable "rds_identifier" {
  type        = string
  description = "RDS instance identifier"
}

variable "rds_engine" {
  type        = string
  description = "RDS engine"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS engine version"
}

variable "rds_username" {
  type        = string
  description = "RDS master username"
}

variable "rds_password" {
  type        = string
  description = "RDS master password"
  sensitive   = true
}

variable "rds_db_name" {
  type        = string
  description = "RDS initial database name"
  default     = null
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type        = number
  description = "RDS allocated storage in GB"
  default     = 20
}

variable "rds_max_allocated_storage" {
  type        = number
  description = "RDS max allocated storage"
  default     = 0
}

variable "rds_storage_type" {
  type        = string
  description = "RDS storage type"
  default     = "gp3"
}

variable "rds_storage_encrypted" {
  type        = bool
  description = "RDS storage encrypted"
  default     = true
}

variable "rds_multi_az" {
  type        = bool
  description = "RDS multi-AZ"
  default     = true
}

variable "rds_backup_retention_period" {
  type        = number
  description = "RDS backup retention period in days"
  default     = 7
}

variable "rds_skip_final_snapshot" {
  type        = bool
  description = "RDS skip final snapshot"
  default     = false
}

variable "rds_deletion_protection" {
  type        = bool
  description = "RDS deletion protection"
  default     = true
}
