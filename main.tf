module "aws_cloudwatch" {
  source = "./modules/aws-cloudwatch"

  log_groups = var.log_groups
  tags       = {}
}

module "terraform_aws_vpc" {
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

module "terraform_aws_security_group" {
  source = "./modules/terraform-aws-security-group"

  name                    = var.security_group_name
  vpc_id                  = module.terraform_aws_vpc.vpc_id
  description             = var.description
  ingress_rules           = var.ingress_rules
  egress_rules            = var.egress_rules
  default_egress_allow_all = var.default_egress_allow_all
  revoke_rules_on_delete  = var.revoke_rules_on_delete
  tags                    = {}
}

module "terraform_aws_subnet" {
  source = "./modules/terraform-aws-subnet"

  name                          = var.subnet_name
  vpc_id                        = module.terraform_aws_vpc.vpc_id
  cidr_block                    = var.subnet_cidr_block
  availability_zone             = var.availability_zone
  map_public_ip_on_launch       = var.map_public_ip_on_launch_subnet
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  ipv6_cidr_block               = var.ipv6_cidr_block
  create_route_table            = var.create_route_table
  route_table_id                = var.route_table_id
  default_route_target_id       = var.default_route_target_id
  default_route_target_type     = var.default_route_target_type
  additional_routes             = var.additional_routes
  tags                          = {}
}

module "terraform_aws_lambda" {
  source = "./modules/terraform-aws-lambda"

  function_name                  = var.function_name
  runtime                        = var.runtime
  handler                        = var.handler
  description                    = var.lambda_description
  filename                       = var.filename
  source_code_hash               = var.source_code_hash
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  architectures                  = var.architectures
  environment_variables          = var.environment_variables
  reserved_concurrent_executions = var.reserved_concurrent_executions
  log_retention_days             = var.log_retention_days
  additional_policy_arns         = var.additional_policy_arns
  tags                           = {}
}
