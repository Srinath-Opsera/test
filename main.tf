module "vpc" {
  source = "./modules/terraform-aws-vpc"

  name                 = var.name
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

module "security_group" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.alb_sg_name
  vpc_id                  = module.vpc.vpc_id
  description             = var.alb_sg_description
  ingress_rules           = var.alb_sg_ingress_rules
  egress_rules            = var.alb_sg_egress_rules
  default_egress_allow_all = var.alb_sg_default_egress_allow_all
  revoke_rules_on_delete  = var.alb_sg_revoke_rules_on_delete
  tags                    = {}
}

module "security_group_2" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.ecs_sg_name
  vpc_id                  = module.vpc.vpc_id
  description             = var.ecs_sg_description
  ingress_rules           = var.ecs_sg_ingress_rules
  egress_rules            = var.ecs_sg_egress_rules
  default_egress_allow_all = var.ecs_sg_default_egress_allow_all
  revoke_rules_on_delete  = var.ecs_sg_revoke_rules_on_delete
  tags                    = {}
}

module "subnet" {
  source = "./modules/terraform-aws-subnet"

  name                          = var.public_subnet_name
  vpc_id                        = module.vpc.vpc_id
  cidr_block                    = var.public_subnet_cidr_block
  availability_zone             = var.public_subnet_availability_zone
  map_public_ip_on_launch       = var.public_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block               = var.public_subnet_ipv6_cidr_block
  create_route_table            = var.public_subnet_create_route_table
  default_route_target_id       = var.public_subnet_default_route_target_id
  default_route_target_type     = var.public_subnet_default_route_target_type
  additional_routes             = var.public_subnet_additional_routes
  tags                          = {}
}

module "subnet_2" {
  source = "./modules/terraform-aws-subnet"

  name                          = var.private_subnet_name
  vpc_id                        = module.vpc.vpc_id
  cidr_block                    = var.private_subnet_cidr_block
  availability_zone             = var.private_subnet_availability_zone
  map_public_ip_on_launch       = var.private_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block               = var.private_subnet_ipv6_cidr_block
  create_route_table            = var.private_subnet_create_route_table
  default_route_target_id       = var.private_subnet_default_route_target_id
  default_route_target_type     = var.private_subnet_default_route_target_type
  additional_routes             = var.private_subnet_additional_routes
  tags                          = {}
}

module "alb" {
  source = "./modules/terraform-aws-alb"

  name                      = var.alb_name
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.public_subnet_ids
  security_group_ids        = [module.security_group.security_group_id]
  certificate_arn           = var.certificate_arn
  internal                  = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout              = var.idle_timeout
  target_port               = var.target_port
  target_protocol           = var.target_protocol
  health_check_path         = var.health_check_path
  ssl_policy                = var.ssl_policy
  additional_certificate_arns = var.additional_certificate_arns
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

module "iam_role" {
  source = "./modules/terraform-aws-iam-role"

  name                   = var.iam_role_name
  assume_role_principals = var.assume_role_principals
  description            = var.iam_role_description
  path                   = var.path
  max_session_duration   = var.max_session_duration
  managed_policy_arns    = var.managed_policy_arns
  inline_policies        = var.inline_policies
  permissions_boundary   = var.permissions_boundary
  force_detach_policies  = var.force_detach_policies
  tags                   = {}
}

module "ecs_fargate" {
  source = "./modules/terraform-aws-ecs-fargate"

  cluster_name        = var.cluster_name
  service_name        = var.service_name
  task_family         = var.task_family
  container_name      = var.container_name
  container_image     = var.container_image
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [module.security_group_2.security_group_id]
  execution_role_arn  = module.iam_role.role_arn
  cpu                 = var.cpu
  memory              = var.memory
  container_port      = var.container_port
  desired_count       = var.desired_count
  assign_public_ip    = var.assign_public_ip
  target_group_arn    = module.alb.target_group_arn
  enable_autoscaling  = var.enable_autoscaling
  autoscaling_min     = var.autoscaling_min
  autoscaling_max     = var.autoscaling_max
  autoscaling_cpu_target = var.autoscaling_cpu_target
  log_retention_days  = var.log_retention_days
  task_role_arn       = var.task_role_arn
  tags                = {}
}
