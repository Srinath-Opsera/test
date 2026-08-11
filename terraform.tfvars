region = "us-east-1"

service_name = "affinity-test"
team         = "platform"
environment  = "staging"

# VPC
vpc_name                 = "affinity-test-staging"
availability_zones       = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.3.0/24", "10.0.4.0/24"]
cidr_block               = "10.0.0.0/16"
enable_nat_gateway       = true
single_nat_gateway       = true
enable_dns_hostnames     = true
enable_dns_support       = true
map_public_ip_on_launch  = true

# Internet Gateway
internet_gateway_name = "affinity-test-staging"

# Public Subnet
public_subnet_name                       = "affinity-test-staging"
public_subnet_cidr_block                 = "10.0.1.0/24"
public_subnet_availability_zone          = "us-east-1a"
public_subnet_map_public_ip_on_launch    = true
public_subnet_assign_ipv6_address_on_creation = false
public_subnet_ipv6_cidr_block            = null
public_subnet_create_route_table         = true
public_subnet_default_route_target_id    = null
public_subnet_default_route_target_type  = "gateway_id"
public_subnet_additional_routes          = []

# Private Subnet
private_subnet_name                       = "affinity-test-staging"
private_subnet_cidr_block                 = "10.0.3.0/24"
private_subnet_availability_zone          = "us-east-1a"
private_subnet_map_public_ip_on_launch    = false
private_subnet_assign_ipv6_address_on_creation = false
private_subnet_ipv6_cidr_block            = null
private_subnet_create_route_table         = true
private_subnet_default_route_target_id    = null
private_subnet_default_route_target_type  = "nat_gateway_id"
private_subnet_additional_routes          = []

# NAT Gateway
nat_gateway_name             = "affinity-test-staging"
nat_gateway_connectivity_type = "public"
nat_gateway_create_eip       = true

# ALB Security Group
security_group_alb_name        = "affinity-test-staging"
security_group_alb_description = "Managed by Terraform"
security_group_alb_ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
security_group_alb_egress_rules            = []
security_group_alb_default_egress_allow_all = true
security_group_alb_revoke_rules_on_delete  = false

# ECS Security Group
security_group_ecs_name        = "affinity-test-staging"
security_group_ecs_description = "Managed by Terraform"
security_group_ecs_ingress_rules = [
  {
    description = "Allow traffic from ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = []
  }
]
security_group_ecs_egress_rules            = []
security_group_ecs_default_egress_allow_all = true
security_group_ecs_revoke_rules_on_delete  = false

# Lambda Security Group
security_group_lambda_name        = "affinity-test-staging"
security_group_lambda_description = "Managed by Terraform"
security_group_lambda_ingress_rules            = []
security_group_lambda_egress_rules             = []
security_group_lambda_default_egress_allow_all = true
security_group_lambda_revoke_rules_on_delete   = false

# ALB
alb_name                      = "affinity-test-staging"
alb_certificate_arn            = ""
alb_internal                   = false
alb_enable_deletion_protection = false
alb_idle_timeout               = 60
alb_target_port                = 8080
alb_target_protocol            = "HTTP"
alb_health_check_path          = "/"
alb_ssl_policy                 = "ELBSecurityPolicy-2016-08"
alb_additional_certificate_arns = []

# CloudWatch
log_groups = {
  "affinity-test-staging" = {
    name              = "/aws/ecs/affinity-test-staging"
    retention_in_days = 30
  }
}
metric_alarms = {}
dashboards    = {}
log_streams   = {}
event_rules   = {}
event_targets = {}

# ECR
ecr_repository_name      = "affinity-test-staging"
ecr_image_tag_mutability = "MUTABLE"
ecr_scan_on_push         = true
ecr_encryption_type      = "AES256"
ecr_kms_key_arn          = null
ecr_force_delete         = false
ecr_lifecycle_policy     = null
ecr_repository_policy    = null
ecr_replication_destinations = []
ecr_replication_filters      = []

# ECS Task IAM Role
iam_role_ecs_name = "affinity-test-staging"
iam_role_ecs_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ecs-tasks.amazonaws.com"]
  }
]
iam_role_ecs_description           = ""
iam_role_ecs_path                  = "/"
iam_role_ecs_max_session_duration  = 3600
iam_role_ecs_managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
iam_role_ecs_inline_policies       = {}
iam_role_ecs_permissions_boundary  = null
iam_role_ecs_force_detach_policies = true

# Lambda IAM Role
iam_role_lambda_name = "affinity-test-staging"
iam_role_lambda_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]
iam_role_lambda_description           = ""
iam_role_lambda_path                  = "/"
iam_role_lambda_max_session_duration  = 3600
iam_role_lambda_managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
iam_role_lambda_inline_policies       = {}
iam_role_lambda_permissions_boundary  = null
iam_role_lambda_force_detach_policies = true

# ECS Fargate
ecs_cluster_name          = "affinity-test-staging"
ecs_service_name          = "test"
ecs_task_family           = "affinity-test-staging"
ecs_container_name        = "affinity-test-staging"
ecs_container_image       = "public.ecr.aws/amazonlinux/amazonlinux:latest"
ecs_cpu                   = 256
ecs_memory                = 512
ecs_container_port        = 8080
ecs_desired_count         = 1
ecs_assign_public_ip      = false
ecs_enable_autoscaling    = false
ecs_autoscaling_min       = 1
ecs_autoscaling_max       = 4
ecs_autoscaling_cpu_target = 70
ecs_log_retention_days    = 30
ecs_task_role_arn         = null

# Lambda Function
lambda_function_name                  = "affinity-test-staging"
lambda_description                    = ""
lambda_runtime                        = null
lambda_handler                        = null
lambda_architecture                   = "x86_64"
lambda_package_type                   = "Image"
lambda_image_uri                      = null
lambda_timeout                        = 30
lambda_memory_size                    = 128
lambda_reserved_concurrent_executions = -1
lambda_publish                        = true
lambda_environment_variables          = {}
lambda_layer_arns                     = []
lambda_create_cloudwatch_log_group    = true
lambda_log_retention_in_days          = 30
lambda_create_alias                   = false
lambda_create_function_url            = false
lambda_allowed_triggers               = {}

# Secrets Manager
secrets_manager_name                             = "affinity-test-staging"
secrets_manager_recovery_window_in_days          = 30
secrets_manager_enable_rotation                  = false
secrets_manager_rotation_automatically_after_days = 30
secrets_manager_block_public_policy              = true
