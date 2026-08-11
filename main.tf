module "vpc" {
  source = "./modules/terraform-aws-vpc"

  name                 = var.vpc_name
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  cidr_block           = var.cidr_block
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                 = {}
}

module "internet_gateway" {
  source = "./modules/aws-internet-gateway"

  name   = var.internet_gateway_name
  vpc_id = module.vpc.vpc_id
  tags   = {}
}

module "public_subnet" {
  source = "./modules/terraform-aws-subnet"

  name                       = var.public_subnet_name
  vpc_id                     = module.vpc.vpc_id
  cidr_block                 = var.public_subnet_cidr_block
  availability_zone          = var.public_subnet_availability_zone
  map_public_ip_on_launch    = var.public_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block            = var.public_subnet_ipv6_cidr_block
  create_route_table         = var.public_subnet_create_route_table
  default_route_target_id    = var.public_subnet_default_route_target_id
  default_route_target_type  = var.public_subnet_default_route_target_type
  additional_routes          = var.public_subnet_additional_routes
  tags                       = {}
}

module "private_subnet" {
  source = "./modules/terraform-aws-subnet"

  name                       = var.private_subnet_name
  vpc_id                     = module.vpc.vpc_id
  cidr_block                 = var.private_subnet_cidr_block
  availability_zone          = var.private_subnet_availability_zone
  map_public_ip_on_launch    = var.private_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block            = var.private_subnet_ipv6_cidr_block
  create_route_table         = var.private_subnet_create_route_table
  default_route_target_id    = var.private_subnet_default_route_target_id
  default_route_target_type  = var.private_subnet_default_route_target_type
  additional_routes          = var.private_subnet_additional_routes
  tags                       = {}
}

module "nat_gateway" {
  source = "./modules/aws-nat-gateway"

  name               = var.nat_gateway_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  connectivity_type  = var.nat_gateway_connectivity_type
  create_eip         = var.nat_gateway_create_eip
  tags               = {}
}

module "security_group_alb" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.security_group_alb_name
  vpc_id                  = module.vpc.vpc_id
  description             = var.security_group_alb_description
  ingress_rules           = var.security_group_alb_ingress_rules
  egress_rules            = var.security_group_alb_egress_rules
  default_egress_allow_all = var.security_group_alb_default_egress_allow_all
  revoke_rules_on_delete  = var.security_group_alb_revoke_rules_on_delete
  tags                    = {}
}

module "security_group_ecs" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.security_group_ecs_name
  vpc_id                  = module.vpc.vpc_id
  description             = var.security_group_ecs_description
  ingress_rules           = var.security_group_ecs_ingress_rules
  egress_rules            = var.security_group_ecs_egress_rules
  default_egress_allow_all = var.security_group_ecs_default_egress_allow_all
  revoke_rules_on_delete  = var.security_group_ecs_revoke_rules_on_delete
  tags                    = {}
}

module "security_group_lambda" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.security_group_lambda_name
  vpc_id                  = module.vpc.vpc_id
  description             = var.security_group_lambda_description
  ingress_rules           = var.security_group_lambda_ingress_rules
  egress_rules            = var.security_group_lambda_egress_rules
  default_egress_allow_all = var.security_group_lambda_default_egress_allow_all
  revoke_rules_on_delete  = var.security_group_lambda_revoke_rules_on_delete
  tags                    = {}
}

module "alb" {
  source = "./modules/terraform-aws-alb"

  name                      = var.alb_name
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.public_subnet_ids
  security_group_ids        = [module.security_group_alb.security_group_id]
  certificate_arn           = var.alb_certificate_arn
  internal                  = var.alb_internal
  enable_deletion_protection = var.alb_enable_deletion_protection
  idle_timeout              = var.alb_idle_timeout
  target_port               = var.alb_target_port
  target_protocol           = var.alb_target_protocol
  health_check_path         = var.alb_health_check_path
  ssl_policy                = var.alb_ssl_policy
  additional_certificate_arns = var.alb_additional_certificate_arns
  tags                      = {}
}

module "cloudwatch" {
  source = "./modules/aws-cloudwatch"

  log_groups    = var.log_groups
  metric_alarms = var.metric_alarms
  dashboards    = var.dashboards
  log_streams   = var.log_streams
  event_rules   = var.event_rules
  event_targets = var.event_targets
  tags          = {}
}

module "ecr_repository" {
  source = "./modules/aws-ecr-repository"

  name                    = var.ecr_repository_name
  image_tag_mutability    = var.ecr_image_tag_mutability
  scan_on_push            = var.ecr_scan_on_push
  encryption_type         = var.ecr_encryption_type
  kms_key_arn             = var.ecr_kms_key_arn
  force_delete            = var.ecr_force_delete
  lifecycle_policy        = var.ecr_lifecycle_policy
  repository_policy       = var.ecr_repository_policy
  replication_destinations = var.ecr_replication_destinations
  replication_filters     = var.ecr_replication_filters
  tags                    = {}
}

module "iam_role_ecs" {
  source = "./modules/terraform-aws-iam-role"

  name                  = var.iam_role_ecs_name
  assume_role_principals = var.iam_role_ecs_assume_role_principals
  description           = var.iam_role_ecs_description
  path                  = var.iam_role_ecs_path
  max_session_duration  = var.iam_role_ecs_max_session_duration
  managed_policy_arns   = var.iam_role_ecs_managed_policy_arns
  inline_policies       = var.iam_role_ecs_inline_policies
  permissions_boundary  = var.iam_role_ecs_permissions_boundary
  force_detach_policies = var.iam_role_ecs_force_detach_policies
  tags                  = {}
}

module "iam_role_lambda" {
  source = "./modules/terraform-aws-iam-role"

  name                  = var.iam_role_lambda_name
  assume_role_principals = var.iam_role_lambda_assume_role_principals
  description           = var.iam_role_lambda_description
  path                  = var.iam_role_lambda_path
  max_session_duration  = var.iam_role_lambda_max_session_duration
  managed_policy_arns   = var.iam_role_lambda_managed_policy_arns
  inline_policies       = var.iam_role_lambda_inline_policies
  permissions_boundary  = var.iam_role_lambda_permissions_boundary
  force_detach_policies = var.iam_role_lambda_force_detach_policies
  tags                  = {}
}

module "ecs_fargate" {
  source = "./modules/terraform-aws-ecs-fargate"

  cluster_name        = var.ecs_cluster_name
  service_name        = var.ecs_service_name
  task_family         = var.ecs_task_family
  container_name      = var.ecs_container_name
  container_image     = var.ecs_container_image
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [module.security_group_ecs.security_group_id]
  execution_role_arn  = module.iam_role_ecs.role_arn
  cpu                 = var.ecs_cpu
  memory              = var.ecs_memory
  container_port      = var.ecs_container_port
  desired_count       = var.ecs_desired_count
  assign_public_ip    = var.ecs_assign_public_ip
  target_group_arn    = module.alb.target_group_arn
  enable_autoscaling  = var.ecs_enable_autoscaling
  autoscaling_min     = var.ecs_autoscaling_min
  autoscaling_max     = var.ecs_autoscaling_max
  autoscaling_cpu_target = var.ecs_autoscaling_cpu_target
  log_retention_days  = var.ecs_log_retention_days
  task_role_arn       = var.ecs_task_role_arn
  tags                = {}
}

module "lambda_function" {
  source = "./modules/aws-lambda-function"

  function_name                  = var.lambda_function_name
  description                    = var.lambda_description
  runtime                        = var.lambda_runtime
  handler                        = var.lambda_handler
  architecture                   = var.lambda_architecture
  package_type                   = var.lambda_package_type
  image_uri                      = var.lambda_image_uri
  timeout                        = var.lambda_timeout
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions
  publish                        = var.lambda_publish
  environment_variables          = var.lambda_environment_variables
  layer_arns                     = var.lambda_layer_arns
  vpc_subnet_ids                 = module.vpc.private_subnet_ids
  vpc_security_group_ids         = [module.security_group_lambda.security_group_id]
  create_iam_role                = false
  existing_role_arn              = module.iam_role_lambda.role_arn
  create_cloudwatch_log_group    = var.lambda_create_cloudwatch_log_group
  log_retention_in_days          = var.lambda_log_retention_in_days
  create_alias                   = var.lambda_create_alias
  create_function_url            = var.lambda_create_function_url
  allowed_triggers               = var.lambda_allowed_triggers
  tags                           = {}
}

module "secrets_manager" {
  source = "./modules/aws-secrets-manager"

  name                             = var.secrets_manager_name
  recovery_window_in_days          = var.secrets_manager_recovery_window_in_days
  enable_rotation                  = var.secrets_manager_enable_rotation
  rotation_automatically_after_days = var.secrets_manager_rotation_automatically_after_days
  block_public_policy              = var.secrets_manager_block_public_policy
  tags                             = {}
}
