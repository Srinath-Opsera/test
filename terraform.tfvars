region = "us-east-1"

log_groups = {
  "affinity-test-staging" = {
    name              = "/aws/lambda/affinity-test-auto"
    retention_in_days = 30
  }
}

name                 = "affinity123-test123-auto"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_block           = "10.0.0.0/16"
enable_nat_gateway   = true
single_nat_gateway   = true
enable_dns_hostnames = true
enable_dns_support   = true
map_public_ip_on_launch = false

security_group_name      = "affinity123-test123-auto"
description              = "Security group for Lambda function"
ingress_rules            = []
egress_rules             = []
default_egress_allow_all = true
revoke_rules_on_delete   = false

subnet_name                   = "affinity123-test123-auto"
subnet_cidr_block             = "10.0.1.0/24"
availability_zone             = "us-east-1a"
map_public_ip_on_launch_subnet = false
assign_ipv6_address_on_creation = false
ipv6_cidr_block               = null
create_route_table            = true
route_table_id                = null
default_route_target_id       = null
default_route_target_type     = "gateway_id"
additional_routes             = []

function_name                  = "affinity123-test123-auto"
runtime                        = "provided"
handler                        = "bootstrap"
lambda_description             = ""
filename                       = "affinity123-test123-auto"
source_code_hash               = null
memory_size                    = 128
timeout                        = 30
architectures                  = ["x86_64"]
environment_variables          = {}
reserved_concurrent_executions = -1
log_retention_days             = 30
additional_policy_arns         = []

default_tags = {
  team = "affinity123"
  service = "test123"
  environment = "auto"
}
