# VPC
module "terraform-aws-vpc--virtual-private-cloud-vpc" {
  source = "./modules/terraform-aws-vpc"

  name                    = var.vpc_name
  cidr_block              = var.vpc_cidr_block
  availability_zones      = var.vpc_availability_zones
  public_subnet_cidrs     = var.vpc_public_subnet_cidrs
  private_subnet_cidrs    = var.vpc_private_subnet_cidrs
  enable_nat_gateway      = var.vpc_enable_nat_gateway
  single_nat_gateway      = var.vpc_single_nat_gateway
  enable_dns_hostnames    = var.vpc_enable_dns_hostnames
  enable_dns_support      = var.vpc_enable_dns_support
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
  tags                    = {}
}

# Internet Gateway
module "aws-internet-gateway" {
  source = "./modules/aws-internet-gateway"

  name   = var.igw_name
  vpc_id = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  tags   = {}
}

# NAT Gateway
module "aws-nat-gateway" {
  source = "./modules/aws-nat-gateway"

  name              = var.nat_name
  subnet_ids        = [module.terraform-aws-subnet--public-subnet.subnet_id]
  nat_gateway_count = var.nat_gateway_count
  connectivity_type = var.nat_connectivity_type
  create_eip        = var.nat_create_eip
  tags              = {}
}

# Public Subnet
module "terraform-aws-subnet--public-subnet" {
  source = "./modules/terraform-aws-subnet"

  name                            = var.public_subnet_name
  vpc_id                          = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  cidr_block                      = var.public_subnet_cidr_block
  availability_zone               = var.public_subnet_availability_zone
  map_public_ip_on_launch         = var.public_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation
  create_route_table              = var.public_subnet_create_route_table
  default_route_target_id         = module.aws-internet-gateway.id
  default_route_target_type       = var.public_subnet_default_route_target_type
  tags                            = {}
}

# Private Subnet
module "terraform-aws-subnet--private-subnet" {
  source = "./modules/terraform-aws-subnet"

  name                            = var.private_subnet_name
  vpc_id                          = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  cidr_block                      = var.private_subnet_cidr_block
  availability_zone               = var.private_subnet_availability_zone
  map_public_ip_on_launch         = var.private_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  create_route_table              = var.private_subnet_create_route_table
  default_route_target_id         = module.aws-nat-gateway.nat_gateway_ids[0]
  default_route_target_type       = var.private_subnet_default_route_target_type
  tags                            = {}
}

# ALB Security Group
module "terraform-aws-security-group--alb-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.alb_sg_name
  vpc_id                   = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  description              = var.alb_sg_description
  ingress_rules            = var.alb_sg_ingress_rules
  egress_rules             = var.alb_sg_egress_rules
  default_egress_allow_all = var.alb_sg_default_egress_allow_all
  revoke_rules_on_delete   = var.alb_sg_revoke_rules_on_delete
  tags                     = {}
}

# ECS Security Group
module "terraform-aws-security-group--ecs-security-group" {
  source = "./modules/terraform-aws-security-group"

  name                     = var.ecs_sg_name
  vpc_id                   = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  description              = var.ecs_sg_description
  ingress_rules            = var.ecs_sg_ingress_rules
  egress_rules             = var.ecs_sg_egress_rules
  default_egress_allow_all = var.ecs_sg_default_egress_allow_all
  revoke_rules_on_delete   = var.ecs_sg_revoke_rules_on_delete
  tags                     = {}
}

# Application Load Balancer
module "terraform-aws-alb--application-load-balancer" {
  source = "./modules/terraform-aws-alb"

  name                        = var.alb_name
  vpc_id                      = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
  subnet_ids                  = module.terraform-aws-vpc--virtual-private-cloud-vpc.public_subnet_ids
  security_group_ids          = [module.terraform-aws-security-group--alb-security-group.security_group_id]
  certificate_arn             = var.alb_certificate_arn
  internal                    = var.alb_internal
  enable_deletion_protection  = var.alb_enable_deletion_protection
  idle_timeout                = var.alb_idle_timeout
  target_port                 = var.alb_target_port
  target_protocol             = var.alb_target_protocol
  health_check_path           = var.alb_health_check_path
  ssl_policy                  = var.alb_ssl_policy
  additional_certificate_arns = var.alb_additional_certificate_arns
  tags                        = {}
}

# CloudWatch Log Group
module "aws-cloudwatch--cloudwatch-log-group" {
  source = "./modules/aws-cloudwatch"

  log_groups    = var.log_groups
  metric_alarms = var.metric_alarms
  dashboards    = var.dashboards
  log_streams   = var.log_streams
  event_rules   = var.event_rules
  event_targets = var.event_targets
  tags          = {}
}

# ECR Repository
module "aws-ecr-repository" {
  source = "./modules/aws-ecr-repository"

  name                 = var.ecr_name
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  encryption_type      = var.ecr_encryption_type
  force_delete         = var.ecr_force_delete
  tags                 = {}
}

# ECS Task Execution IAM Role
module "terraform-aws-iam-role--ecs-task-execution-iam-role" {
  source = "./modules/terraform-aws-iam-role"

  name                   = var.ecs_exec_role_name
  assume_role_principals = var.ecs_exec_role_assume_role_principals
  description            = var.ecs_exec_role_description
  path                   = var.ecs_exec_role_path
  max_session_duration   = var.ecs_exec_role_max_session_duration
  managed_policy_arns    = var.ecs_exec_role_managed_policy_arns
  inline_policies        = var.ecs_exec_role_inline_policies
  force_detach_policies  = var.ecs_exec_role_force_detach_policies
  tags                   = {}
}

# ECS Task IAM Role
module "terraform-aws-iam-role--ecs-task-iam-role" {
  source = "./modules/terraform-aws-iam-role"

  name                   = var.ecs_task_role_name
  assume_role_principals = var.ecs_task_role_assume_role_principals
  description            = var.ecs_task_role_description
  path                   = var.ecs_task_role_path
  max_session_duration   = var.ecs_task_role_max_session_duration
  managed_policy_arns    = var.ecs_task_role_managed_policy_arns
  inline_policies        = var.ecs_task_role_inline_policies
  force_detach_policies  = var.ecs_task_role_force_detach_policies
  tags                   = {}
}

# ECS Fargate (Cluster + Service + Task Definition)
module "terraform-aws-ecs-fargate--ecs-cluster" {
  source = "./modules/terraform-aws-ecs-fargate"

  cluster_name           = var.ecs_cluster_name
  service_name           = var.ecs_cluster_service_name
  task_family            = var.ecs_cluster_task_family
  container_name         = var.ecs_cluster_container_name
  container_image        = var.container_image
  subnet_ids             = module.terraform-aws-vpc--virtual-private-cloud-vpc.private_subnet_ids
  security_group_ids     = [module.terraform-aws-security-group--ecs-security-group.security_group_id]
  execution_role_arn     = module.terraform-aws-iam-role--ecs-task-execution-iam-role.role_arn
  task_role_arn          = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
  cpu                    = var.ecs_cluster_cpu
  memory                 = var.ecs_cluster_memory
  container_port         = var.ecs_cluster_container_port
  desired_count          = var.ecs_cluster_desired_count
  assign_public_ip       = var.ecs_cluster_assign_public_ip
  target_group_arn       = module.terraform-aws-alb--application-load-balancer.target_group_arn
  enable_autoscaling     = var.ecs_cluster_enable_autoscaling
  autoscaling_min        = var.ecs_cluster_autoscaling_min
  autoscaling_max        = var.ecs_cluster_autoscaling_max
  autoscaling_cpu_target = var.ecs_cluster_autoscaling_cpu_target
  log_retention_days     = var.ecs_cluster_log_retention_days
  tags                   = {}
}

# Auto Scaling Policy
module "aws-auto-scaling-policy" {
  source = "./modules/aws-auto-scaling-policy"

  name                          = var.asg_policy_name
  autoscaling_group_name        = var.asg_policy_autoscaling_group_name
  policy_type                   = var.asg_policy_type
  cooldown                      = var.asg_policy_cooldown
  target_tracking_configuration = var.asg_policy_target_tracking_configuration
  tags                          = {}
}
