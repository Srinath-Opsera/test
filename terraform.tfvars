region = "us-east-1"

name                 = "affinity-test-staging"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
cidr_block           = "10.0.0.0/16"
enable_nat_gateway   = true
single_nat_gateway   = true
enable_dns_hostnames = true
enable_dns_support   = true
map_public_ip_on_launch = true

alb_sg_name        = "affinity-test-staging"
alb_sg_description = "Managed by Terraform"
alb_sg_ingress_rules = [
  {
  },
  {
  }
]
alb_sg_egress_rules = [
  {
  }
]
alb_sg_default_egress_allow_all = true
alb_sg_revoke_rules_on_delete   = false

ecs_sg_name        = "affinity-test-staging"
ecs_sg_description = "Managed by Terraform"
ecs_sg_ingress_rules = [
  {
  }
]
ecs_sg_egress_rules = [
  {
  }
]
ecs_sg_default_egress_allow_all = true
ecs_sg_revoke_rules_on_delete   = false

public_subnet_name                        = "affinity-test-staging"
public_subnet_cidr_block                  = "10.0.1.0/24"
public_subnet_availability_zone           = "us-east-1a"
public_subnet_map_public_ip_on_launch     = true
public_subnet_assign_ipv6_address_on_creation = false
public_subnet_ipv6_cidr_block             = null
public_subnet_create_route_table          = true
public_subnet_default_route_target_id     = null
public_subnet_default_route_target_type   = "gateway_id"
public_subnet_additional_routes           = []

private_subnet_name                        = "affinity-test-staging"
private_subnet_cidr_block                  = "10.0.3.0/24"
private_subnet_availability_zone           = "us-east-1a"
private_subnet_map_public_ip_on_launch     = false
private_subnet_assign_ipv6_address_on_creation = false
private_subnet_ipv6_cidr_block             = null
private_subnet_create_route_table          = true
private_subnet_default_route_target_id     = null
private_subnet_default_route_target_type   = "nat_gateway_id"
private_subnet_additional_routes           = []

alb_name                    = "affinity-test-staging"
certificate_arn             = ""
internal                    = false
enable_deletion_protection  = false
idle_timeout                = 60
target_port                 = 8080
target_protocol             = "HTTP"
health_check_path           = "/"
ssl_policy                  = "ELBSecurityPolicy-2016-08"
additional_certificate_arns = []

log_groups = {
  "affinity-test-staging" = {
    name              = "/ecs/affinity-test-staging"
  }
}
metric_alarms = {}
dashboards    = {}
log_streams   = {}
event_rules   = {}
event_targets = {}

iam_role_name   = "affinity-test-staging"
assume_role_principals = [
  {
  }
]
iam_role_description  = ""
path                  = "/"
max_session_duration  = 3600
managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
inline_policies       = {}
permissions_boundary  = null
force_detach_policies = true

cluster_name           = "affinity-test-staging"
service_name           = "test"
task_family            = "affinity-test-staging"
container_name         = "affinity-test-staging"
container_image        = "{accountId}.dkr.ecr.us-east-1.amazonaws.com/ecr-affinity-test-staging:latest"
cpu                    = 256
memory                 = 512
container_port         = 8080
desired_count          = 1
assign_public_ip       = false
enable_autoscaling     = false
autoscaling_min        = 2
autoscaling_max        = 10
autoscaling_cpu_target = 70
log_retention_days     = 30
task_role_arn          = null
team = "affinity"
environment = "staging"
