module "terraform-aws-vpc--virtual-private-cloud-vpc" {
  source = "./modules/terraform-aws-vpc"

  name                    = var.terraform_aws_vpc__virtual_private_cloud_vpc__name
  availability_zones      = var.terraform_aws_vpc__virtual_private_cloud_vpc__availability_zones
  public_subnet_cidrs     = var.terraform_aws_vpc__virtual_private_cloud_vpc__public_subnet_cidrs
  private_subnet_cidrs    = var.terraform_aws_vpc__virtual_private_cloud_vpc__private_subnet_cidrs
  cidr_block              = var.terraform_aws_vpc__virtual_private_cloud_vpc__cidr_block
  enable_nat_gateway      = var.terraform_aws_vpc__virtual_private_cloud_vpc__enable_nat_gateway
  single_nat_gateway      = var.terraform_aws_vpc__virtual_private_cloud_vpc__single_nat_gateway
  enable_dns_hostnames    = var.terraform_aws_vpc__virtual_private_cloud_vpc__enable_dns_hostnames
  enable_dns_support      = var.terraform_aws_vpc__virtual_private_cloud_vpc__enable_dns_support
  map_public_ip_on_launch = var.terraform_aws_vpc__virtual_private_cloud_vpc__map_public_ip_on_launch
  tags                    = {}
}

module "terraform-aws-subnet--public-subnet" {
  source = "./modules/terraform-aws-subnet"

  name                            = var.terraform_aws_subnet__public_subnet__name
  vpc_id                          = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  cidr_block                      = var.terraform_aws_subnet__public_subnet__cidr_block
  availability_zone               = var.terraform_aws_subnet__public_subnet__availability_zone
  map_public_ip_on_launch         = var.terraform_aws_subnet__public_subnet__map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.terraform_aws_subnet__public_subnet__assign_ipv6_address_on_creation
  ipv6_cidr_block                 = var.terraform_aws_subnet__public_subnet__ipv6_cidr_block
  create_route_table              = var.terraform_aws_subnet__public_subnet__create_route_table
  default_route_target_id         = var.terraform_aws_subnet__public_subnet__default_route_target_id
  default_route_target_type       = var.terraform_aws_subnet__public_subnet__default_route_target_type
  additional_routes               = var.terraform_aws_subnet__public_subnet__additional_routes
  tags                            = {}
}

module "terraform-aws-subnet--private-subnet" {
  source = "./modules/terraform-aws-subnet"

  name                            = var.terraform_aws_subnet__private_subnet__name
  vpc_id                          = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  cidr_block                      = var.terraform_aws_subnet__private_subnet__cidr_block
  availability_zone               = var.terraform_aws_subnet__private_subnet__availability_zone
  map_public_ip_on_launch         = var.terraform_aws_subnet__private_subnet__map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.terraform_aws_subnet__private_subnet__assign_ipv6_address_on_creation
  ipv6_cidr_block                 = var.terraform_aws_subnet__private_subnet__ipv6_cidr_block
  create_route_table              = var.terraform_aws_subnet__private_subnet__create_route_table
  route_table_id                  = module.terraform-aws-subnet--public-subnet.route_table_id
  default_route_target_id         = var.terraform_aws_subnet__private_subnet__default_route_target_id
  default_route_target_type       = var.terraform_aws_subnet__private_subnet__default_route_target_type
  additional_routes               = var.terraform_aws_subnet__private_subnet__additional_routes
  tags                            = {}
}

module "terraform-aws-security-group--alb-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.terraform_aws_security_group__alb_security_group__name
  vpc_id                   = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  description              = var.terraform_aws_security_group__alb_security_group__description
  ingress_rules            = var.terraform_aws_security_group__alb_security_group__ingress_rules
  egress_rules             = var.terraform_aws_security_group__alb_security_group__egress_rules
  default_egress_allow_all = var.terraform_aws_security_group__alb_security_group__default_egress_allow_all
  revoke_rules_on_delete   = var.terraform_aws_security_group__alb_security_group__revoke_rules_on_delete
  tags                     = {}
}

module "terraform-aws-security-group--ecs-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.terraform_aws_security_group__ecs_security_group__name
  vpc_id                   = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  description              = var.terraform_aws_security_group__ecs_security_group__description
  ingress_rules            = var.terraform_aws_security_group__ecs_security_group__ingress_rules
  egress_rules             = var.terraform_aws_security_group__ecs_security_group__egress_rules
  default_egress_allow_all = var.terraform_aws_security_group__ecs_security_group__default_egress_allow_all
  revoke_rules_on_delete   = var.terraform_aws_security_group__ecs_security_group__revoke_rules_on_delete
  tags                     = {}
}

module "terraform-aws-security-group--lambda-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.terraform_aws_security_group__lambda_security_group__name
  vpc_id                   = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  description              = var.terraform_aws_security_group__lambda_security_group__description
  ingress_rules            = var.terraform_aws_security_group__lambda_security_group__ingress_rules
  egress_rules             = var.terraform_aws_security_group__lambda_security_group__egress_rules
  default_egress_allow_all = var.terraform_aws_security_group__lambda_security_group__default_egress_allow_all
  revoke_rules_on_delete   = var.terraform_aws_security_group__lambda_security_group__revoke_rules_on_delete
  tags                     = {}
}

module "terraform-aws-security-group--rds-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.terraform_aws_security_group__rds_security_group__name
  vpc_id                   = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  description              = var.terraform_aws_security_group__rds_security_group__description
  ingress_rules            = var.terraform_aws_security_group__rds_security_group__ingress_rules
  egress_rules             = var.terraform_aws_security_group__rds_security_group__egress_rules
  default_egress_allow_all = var.terraform_aws_security_group__rds_security_group__default_egress_allow_all
  revoke_rules_on_delete   = var.terraform_aws_security_group__rds_security_group__revoke_rules_on_delete
  tags                     = {}
}

module "terraform-aws-alb--application-load-balancer" {
  source = "./modules/terraform-aws-alb"

  name                        = var.terraform_aws_alb__application_load_balancer__name
  vpc_id                      = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  subnet_ids                  = module.terraform-aws-vpc--virtual-private-cloud-vpc.public_subnet_ids
  security_group_ids          = [module.terraform-aws-security-group--alb-security-group.security_group_id]
  certificate_arn             = var.terraform_aws_alb__application_load_balancer__certificate_arn
  internal                    = var.terraform_aws_alb__application_load_balancer__internal
  enable_deletion_protection  = var.terraform_aws_alb__application_load_balancer__enable_deletion_protection
  idle_timeout                = var.terraform_aws_alb__application_load_balancer__idle_timeout
  target_port                 = var.terraform_aws_alb__application_load_balancer__target_port
  target_protocol             = var.terraform_aws_alb__application_load_balancer__target_protocol
  health_check_path           = var.terraform_aws_alb__application_load_balancer__health_check_path
  ssl_policy                  = var.terraform_aws_alb__application_load_balancer__ssl_policy
  additional_certificate_arns = var.terraform_aws_alb__application_load_balancer__additional_certificate_arns
  tags                        = {}
}

module "terraform-aws-iam-role--ecs-task-iam-role" {
  source = "./modules/terraform-aws-iam-role"

  name                   = var.terraform_aws_iam_role__ecs_task_iam_role__name
  assume_role_principals = var.terraform_aws_iam_role__ecs_task_iam_role__assume_role_principals
  description            = var.terraform_aws_iam_role__ecs_task_iam_role__description
  path                   = var.terraform_aws_iam_role__ecs_task_iam_role__path
  max_session_duration   = var.terraform_aws_iam_role__ecs_task_iam_role__max_session_duration
  managed_policy_arns    = var.terraform_aws_iam_role__ecs_task_iam_role__managed_policy_arns
  inline_policies        = var.terraform_aws_iam_role__ecs_task_iam_role__inline_policies
  permissions_boundary   = var.terraform_aws_iam_role__ecs_task_iam_role__permissions_boundary
  force_detach_policies  = var.terraform_aws_iam_role__ecs_task_iam_role__force_detach_policies
  tags                   = {}
}

module "terraform-aws-iam-role--lambda-iam-role" {
  source = "./modules/terraform-aws-iam-role"

  name                   = var.terraform_aws_iam_role__lambda_iam_role__name
  assume_role_principals = var.terraform_aws_iam_role__lambda_iam_role__assume_role_principals
  description            = var.terraform_aws_iam_role__lambda_iam_role__description
  path                   = var.terraform_aws_iam_role__lambda_iam_role__path
  max_session_duration   = var.terraform_aws_iam_role__lambda_iam_role__max_session_duration
  managed_policy_arns    = var.terraform_aws_iam_role__lambda_iam_role__managed_policy_arns
  inline_policies        = var.terraform_aws_iam_role__lambda_iam_role__inline_policies
  permissions_boundary   = var.terraform_aws_iam_role__lambda_iam_role__permissions_boundary
  force_detach_policies  = var.terraform_aws_iam_role__lambda_iam_role__force_detach_policies
  tags                   = {}
}

module "terraform-aws-ecs-fargate--ecs-cluster" {
  source = "./modules/terraform-aws-ecs-fargate"

  cluster_name           = var.terraform_aws_ecs_fargate__ecs_cluster__cluster_name
  service_name           = var.terraform_aws_ecs_fargate__ecs_cluster__service_name
  task_family            = var.terraform_aws_ecs_fargate__ecs_cluster__task_family
  container_name         = var.terraform_aws_ecs_fargate__ecs_cluster__container_name
  container_image        = var.terraform_aws_ecs_fargate__ecs_cluster__container_image
  subnet_ids             = module.terraform-aws-vpc--virtual-private-cloud-vpc.private_subnet_ids
  security_group_ids     = [module.terraform-aws-security-group--ecs-security-group.security_group_id]
  execution_role_arn     = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
  cpu                    = var.terraform_aws_ecs_fargate__ecs_cluster__cpu
  memory                 = var.terraform_aws_ecs_fargate__ecs_cluster__memory
  container_port         = var.terraform_aws_ecs_fargate__ecs_cluster__container_port
  desired_count          = var.terraform_aws_ecs_fargate__ecs_cluster__desired_count
  assign_public_ip       = var.terraform_aws_ecs_fargate__ecs_cluster__assign_public_ip
  target_group_arn       = module.terraform-aws-alb--application-load-balancer.target_group_arn
  enable_autoscaling     = var.terraform_aws_ecs_fargate__ecs_cluster__enable_autoscaling
  autoscaling_min        = var.terraform_aws_ecs_fargate__ecs_cluster__autoscaling_min
  autoscaling_max        = var.terraform_aws_ecs_fargate__ecs_cluster__autoscaling_max
  autoscaling_cpu_target = var.terraform_aws_ecs_fargate__ecs_cluster__autoscaling_cpu_target
  log_retention_days     = var.terraform_aws_ecs_fargate__ecs_cluster__log_retention_days
  task_role_arn          = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
  tags                   = {}
}

module "terraform-aws-ecs-fargate--ecs-fargate-service" {
  source = "./modules/terraform-aws-ecs-fargate"

  cluster_name           = var.terraform_aws_ecs_fargate__ecs_fargate_service__cluster_name
  service_name           = var.terraform_aws_ecs_fargate__ecs_fargate_service__service_name
  task_family            = var.terraform_aws_ecs_fargate__ecs_fargate_service__task_family
  container_name         = var.terraform_aws_ecs_fargate__ecs_fargate_service__container_name
  container_image        = var.terraform_aws_ecs_fargate__ecs_fargate_service__container_image
  subnet_ids             = module.terraform-aws-vpc--virtual-private-cloud-vpc.private_subnet_ids
  security_group_ids     = [module.terraform-aws-security-group--ecs-security-group.security_group_id]
  execution_role_arn     = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
  cpu                    = var.terraform_aws_ecs_fargate__ecs_fargate_service__cpu
  memory                 = var.terraform_aws_ecs_fargate__ecs_fargate_service__memory
  container_port         = var.terraform_aws_ecs_fargate__ecs_fargate_service__container_port
  desired_count          = var.terraform_aws_ecs_fargate__ecs_fargate_service__desired_count
  assign_public_ip       = var.terraform_aws_ecs_fargate__ecs_fargate_service__assign_public_ip
  target_group_arn       = module.terraform-aws-alb--application-load-balancer.target_group_arn
  enable_autoscaling     = var.terraform_aws_ecs_fargate__ecs_fargate_service__enable_autoscaling
  autoscaling_min        = var.terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_min
  autoscaling_max        = var.terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_max
  autoscaling_cpu_target = var.terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_cpu_target
  log_retention_days     = var.terraform_aws_ecs_fargate__ecs_fargate_service__log_retention_days
  task_role_arn          = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
  tags                   = {}
}

module "terraform-aws-rds--rds-aurora-postgresql" {
  source = "./modules/terraform-aws-rds"

  identifier              = var.terraform_aws_rds__rds_aurora_postgresql__identifier
  engine                  = var.terraform_aws_rds__rds_aurora_postgresql__engine
  engine_version          = var.terraform_aws_rds__rds_aurora_postgresql__engine_version
  username                = var.terraform_aws_rds__rds_aurora_postgresql__username
  password                = var.terraform_aws_rds__rds_aurora_postgresql__password
  db_subnet_group_name    = var.terraform_aws_rds__rds_aurora_postgresql__db_subnet_group_name
  vpc_security_group_ids  = [module.terraform-aws-security-group--rds-security-group.security_group_id]
  instance_class          = var.terraform_aws_rds__rds_aurora_postgresql__instance_class
  allocated_storage       = var.terraform_aws_rds__rds_aurora_postgresql__allocated_storage
  max_allocated_storage   = var.terraform_aws_rds__rds_aurora_postgresql__max_allocated_storage
  storage_type            = var.terraform_aws_rds__rds_aurora_postgresql__storage_type
  storage_encrypted       = var.terraform_aws_rds__rds_aurora_postgresql__storage_encrypted
  kms_key_id              = var.terraform_aws_rds__rds_aurora_postgresql__kms_key_id
  db_name                 = var.terraform_aws_rds__rds_aurora_postgresql__db_name
  multi_az                = var.terraform_aws_rds__rds_aurora_postgresql__multi_az
  backup_retention_period = var.terraform_aws_rds__rds_aurora_postgresql__backup_retention_period
  deletion_protection     = var.terraform_aws_rds__rds_aurora_postgresql__deletion_protection
  skip_final_snapshot     = var.terraform_aws_rds__rds_aurora_postgresql__skip_final_snapshot
  tags                    = {}
}

module "terraform-aws-s3--s3-bucket" {
  source = "./modules/terraform-aws-s3"

  bucket_name             = var.terraform_aws_s3__s3_bucket__bucket_name
  force_destroy           = var.terraform_aws_s3__s3_bucket__force_destroy
  versioning_enabled      = var.terraform_aws_s3__s3_bucket__versioning_enabled
  sse_algorithm           = var.terraform_aws_s3__s3_bucket__sse_algorithm
  kms_master_key_id       = var.terraform_aws_s3__s3_bucket__kms_master_key_id
  block_public_acls       = var.terraform_aws_s3__s3_bucket__block_public_acls
  block_public_policy     = var.terraform_aws_s3__s3_bucket__block_public_policy
  ignore_public_acls      = var.terraform_aws_s3__s3_bucket__ignore_public_acls
  restrict_public_buckets = var.terraform_aws_s3__s3_bucket__restrict_public_buckets
  lifecycle_rules         = var.terraform_aws_s3__s3_bucket__lifecycle_rules
  bucket_policy_json      = var.terraform_aws_s3__s3_bucket__bucket_policy_json
  tags                    = {}
}

module "aws-secrets-manager" {
  source = "./modules/aws-secrets-manager"

  name                              = var.aws_secrets_manager__name
  description                       = var.aws_secrets_manager__description
  kms_key_id                        = var.aws_secrets_manager__kms_key_id
  recovery_window_in_days           = var.aws_secrets_manager__recovery_window_in_days
  secret_string                     = var.aws_secrets_manager__secret_string
  secret_key_value_pairs            = var.aws_secrets_manager__secret_key_value_pairs
  secret_binary                     = var.aws_secrets_manager__secret_binary
  enable_rotation                   = var.aws_secrets_manager__enable_rotation
  rotation_lambda_arn               = var.aws_secrets_manager__rotation_lambda_arn
  rotation_automatically_after_days = var.aws_secrets_manager__rotation_automatically_after_days
  block_public_policy               = var.aws_secrets_manager__block_public_policy
  tags                              = {}
}

module "aws-cloudwatch--cloudwatch-alarms" {
  source = "./modules/aws-cloudwatch"

  log_groups    = var.aws_cloudwatch__cloudwatch_alarms__log_groups
  metric_alarms = var.aws_cloudwatch__cloudwatch_alarms__metric_alarms
  dashboards    = var.aws_cloudwatch__cloudwatch_alarms__dashboards
  log_streams   = var.aws_cloudwatch__cloudwatch_alarms__log_streams
  event_rules   = var.aws_cloudwatch__cloudwatch_alarms__event_rules
  event_targets = var.aws_cloudwatch__cloudwatch_alarms__event_targets
  tags          = {}
}

module "aws-cloudwatch--cloudwatch-log-group" {
  source = "./modules/aws-cloudwatch"

  log_groups    = var.aws_cloudwatch__cloudwatch_log_group__log_groups
  metric_alarms = var.aws_cloudwatch__cloudwatch_log_group__metric_alarms
  dashboards    = var.aws_cloudwatch__cloudwatch_log_group__dashboards
  log_streams   = var.aws_cloudwatch__cloudwatch_log_group__log_streams
  event_rules   = var.aws_cloudwatch__cloudwatch_log_group__event_rules
  event_targets = var.aws_cloudwatch__cloudwatch_log_group__event_targets
  tags          = {}
}
