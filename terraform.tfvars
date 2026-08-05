region = "us-east-1"

# VPC
vpc_name                    = "affinity-test-dev"
vpc_cidr_block              = "10.0.0.0/16"
vpc_availability_zones      = ["us-east-1a", "us-east-1b"]
vpc_public_subnet_cidrs     = ["10.0.1.0/24", "10.0.3.0/24"]
vpc_private_subnet_cidrs    = ["10.0.2.0/24", "10.0.4.0/24"]
vpc_enable_nat_gateway      = true
vpc_single_nat_gateway      = true
vpc_enable_dns_hostnames    = true
vpc_enable_dns_support      = true
vpc_map_public_ip_on_launch = true

# Internet Gateway
igw_name = "affinity-test-dev"

# NAT Gateway
nat_name              = "affinity-test-dev"
nat_gateway_count     = 1
nat_connectivity_type = "public"
nat_create_eip        = true

# Public Subnet
public_subnet_name                            = "public-affinity-test-dev"
public_subnet_cidr_block                      = "10.0.1.0/24"
public_subnet_availability_zone               = "us-east-1a"
public_subnet_map_public_ip_on_launch         = true
public_subnet_assign_ipv6_address_on_creation = false
public_subnet_create_route_table              = true
public_subnet_default_route_target_type       = "gateway_id"

# Private Subnet
private_subnet_name                            = "private-affinity-test-dev"
private_subnet_cidr_block                      = "10.0.2.0/24"
private_subnet_availability_zone               = "us-east-1a"
private_subnet_map_public_ip_on_launch         = false
private_subnet_assign_ipv6_address_on_creation = false
private_subnet_create_route_table              = true
private_subnet_default_route_target_type       = "nat_gateway_id"

# ALB Security Group
alb_sg_name        = "alb-affinity-test-dev"
alb_sg_description = "Security group for ALB affinity-test"
alb_sg_ingress_rules = [
  {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
alb_sg_egress_rules             = []
alb_sg_default_egress_allow_all = true
alb_sg_revoke_rules_on_delete   = false

# ECS Security Group
ecs_sg_name                     = "ecs-affinity-test-dev"
ecs_sg_description              = "Security group for ECS Fargate tasks - affinity test dev"
ecs_sg_ingress_rules            = []
ecs_sg_egress_rules             = []
ecs_sg_default_egress_allow_all = true
ecs_sg_revoke_rules_on_delete   = false

# ALB
alb_name                        = "alb-affinity-test-dev"
alb_certificate_arn              = ""
alb_internal                     = false
alb_enable_deletion_protection   = false
alb_idle_timeout                 = 60
alb_target_port                  = 80
alb_target_protocol              = "HTTP"
alb_health_check_path            = "/"
alb_ssl_policy                   = "ELBSecurityPolicy-2016-08"
alb_additional_certificate_arns  = []

# CloudWatch
log_groups = {
  "ecs-affinity-test-dev" = {
    name              = "/ecs/affinity-test-dev"
    retention_in_days = 30
    kms_key_id        = null
    tags              = {}
  }
}
metric_alarms = {}
dashboards    = {}
log_streams   = {}
event_rules   = {}
event_targets = {}

# ECR
ecr_name                 = "affinity-test-dev"
ecr_image_tag_mutability = "MUTABLE"
ecr_scan_on_push         = true
ecr_encryption_type      = "AES256"
ecr_force_delete         = false

# ECS Task Execution IAM Role
ecs_exec_role_name = "role-ecs-exec-affinity-test-dev"
ecs_exec_role_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ecs-tasks.amazonaws.com"]
  }
]
ecs_exec_role_description           = "ECS Task Execution IAM Role for affinity test service - dev"
ecs_exec_role_path                  = "/"
ecs_exec_role_max_session_duration  = 3600
ecs_exec_role_managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
ecs_exec_role_inline_policies       = {}
ecs_exec_role_force_detach_policies = true

# ECS Task IAM Role
ecs_task_role_name = "role-ecs-task-affinity-test-dev"
ecs_task_role_assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ecs-tasks.amazonaws.com"]
  }
]
ecs_task_role_description           = "ECS Task IAM Role for service test (affinity team)"
ecs_task_role_path                  = "/"
ecs_task_role_max_session_duration  = 3600
ecs_task_role_managed_policy_arns   = []
ecs_task_role_inline_policies       = {}
ecs_task_role_force_detach_policies = true

# ECS Cluster / Fargate
ecs_cluster_name               = "ecs-cluster-affinity-test-dev"
ecs_cluster_service_name       = "test"
ecs_cluster_task_family        = "ecs-cluster-affinity-test-dev"
ecs_cluster_container_name     = "ecs-cluster-affinity-test-dev"
container_image                = "public.ecr.aws/amazonlinux/amazonlinux:latest"
ecs_cluster_cpu                = 256
ecs_cluster_memory             = 512
ecs_cluster_container_port     = 8080
ecs_cluster_desired_count      = 1
ecs_cluster_assign_public_ip   = false
ecs_cluster_enable_autoscaling = true
ecs_cluster_autoscaling_min    = 1
ecs_cluster_autoscaling_max    = 4
ecs_cluster_autoscaling_cpu_target = 70
ecs_cluster_log_retention_days = 30

# Auto Scaling Policy
asg_policy_name                   = "asg-policy-affinity-test-dev"
asg_policy_autoscaling_group_name = "affinity-test-dev"
asg_policy_type                   = "TargetTrackingScaling"
asg_policy_cooldown               = 300
asg_policy_target_tracking_configuration = {
  target_value           = 75
  predefined_metric_type = "ECSServiceAverageCPUUtilization"
}

default_tags = {
  team = "affinity"
  service = "test"
  environment = "dev"
  managed_by = "cloudforge"
}
