output "vpc_id" {
  description = "VPC ID"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "Internet gateway ID"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.internet_gateway_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.nat_gateway_ids
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.terraform-aws-subnet--public-subnet.subnet_id
}

output "public_subnet_cidr_block" {
  description = "Public subnet CIDR block"
  value       = module.terraform-aws-subnet--public-subnet.subnet_cidr_block
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = module.terraform-aws-subnet--public-subnet.route_table_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.terraform-aws-subnet--private-subnet.subnet_id
}

output "private_subnet_cidr_block" {
  description = "Private subnet CIDR block"
  value       = module.terraform-aws-subnet--private-subnet.subnet_cidr_block
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = module.terraform-aws-subnet--private-subnet.route_table_id
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = module.terraform-aws-security-group--alb-security-group.security_group_id
}

output "ecs_security_group_id" {
  description = "ECS security group ID"
  value       = module.terraform-aws-security-group--ecs-security-group.security_group_id
}

output "lambda_security_group_id" {
  description = "Lambda security group ID"
  value       = module.terraform-aws-security-group--lambda-security-group.security_group_id
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = module.terraform-aws-security-group--rds-security-group.security_group_id
}

output "lb_id" {
  description = "ALB ID"
  value       = module.terraform-aws-alb--application-load-balancer.lb_id
}

output "lb_arn" {
  description = "ALB ARN"
  value       = module.terraform-aws-alb--application-load-balancer.lb_arn
}

output "lb_dns_name" {
  description = "ALB DNS name"
  value       = module.terraform-aws-alb--application-load-balancer.lb_dns_name
}

output "lb_zone_id" {
  description = "ALB zone ID"
  value       = module.terraform-aws-alb--application-load-balancer.lb_zone_id
}

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = module.terraform-aws-alb--application-load-balancer.target_group_arn
}

output "https_listener_arn" {
  description = "ALB HTTPS listener ARN"
  value       = module.terraform-aws-alb--application-load-balancer.https_listener_arn
}

output "ecs_task_role_arn" {
  description = "ECS task IAM role ARN"
  value       = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
}

output "ecs_task_role_name" {
  description = "ECS task IAM role name"
  value       = module.terraform-aws-iam-role--ecs-task-iam-role.role_name
}

output "lambda_role_arn" {
  description = "Lambda IAM role ARN"
  value       = module.terraform-aws-iam-role--lambda-iam-role.role_arn
}

output "lambda_role_name" {
  description = "Lambda IAM role name"
  value       = module.terraform-aws-iam-role--lambda-iam-role.role_name
}

output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.cluster_id
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.cluster_arn
}

output "ecs_service_id" {
  description = "ECS service ID"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.service_id
}

output "ecs_task_definition_arn" {
  description = "ECS task definition ARN"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.task_definition_arn
}

output "ecs_log_group_name" {
  description = "ECS log group name"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.log_group_name
}

output "ecs_fargate_service_id" {
  description = "ECS Fargate service ID"
  value       = module.terraform-aws-ecs-fargate--ecs-fargate-service.service_id
}

output "ecs_fargate_service_name" {
  description = "ECS Fargate service name"
  value       = module.terraform-aws-ecs-fargate--ecs-fargate-service.service_name
}

output "ecs_fargate_task_definition_arn" {
  description = "ECS Fargate task definition ARN"
  value       = module.terraform-aws-ecs-fargate--ecs-fargate-service.task_definition_arn
}

output "db_instance_address" {
  description = "RDS instance address"
  value       = module.terraform-aws-rds--rds-aurora-postgresql.db_instance_address
}

output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.terraform-aws-rds--rds-aurora-postgresql.db_instance_endpoint
}

output "db_instance_port" {
  description = "RDS instance port"
  value       = module.terraform-aws-rds--rds-aurora-postgresql.db_instance_port
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = module.terraform-aws-rds--rds-aurora-postgresql.db_instance_arn
}

output "db_instance_id" {
  description = "RDS instance ID"
  value       = module.terraform-aws-rds--rds-aurora-postgresql.db_instance_id
}

output "bucket_id" {
  description = "S3 bucket ID"
  value       = module.terraform-aws-s3--s3-bucket.bucket_id
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.terraform-aws-s3--s3-bucket.bucket_arn
}

output "bucket_domain_name" {
  description = "S3 bucket domain name"
  value       = module.terraform-aws-s3--s3-bucket.bucket_domain_name
}

output "secret_arn" {
  description = "Secrets Manager secret ARN"
  value       = module.aws-secrets-manager.secret_arn
}

output "secret_name" {
  description = "Secrets Manager secret name"
  value       = module.aws-secrets-manager.secret_name
}

output "cloudwatch_alarms_log_group_names" {
  description = "CloudWatch alarms log group names"
  value       = module.aws-cloudwatch--cloudwatch-alarms.log_group_names
}

output "cloudwatch_alarms_log_group_arns" {
  description = "CloudWatch alarms log group ARNs"
  value       = module.aws-cloudwatch--cloudwatch-alarms.log_group_arns
}

output "cloudwatch_log_group_names" {
  description = "CloudWatch log group names"
  value       = module.aws-cloudwatch--cloudwatch-log-group.log_group_names
}

output "cloudwatch_log_group_arns" {
  description = "CloudWatch log group ARNs"
  value       = module.aws-cloudwatch--cloudwatch-log-group.log_group_arns
}
