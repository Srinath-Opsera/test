module "terraform_aws_vpc" {
  source = "./modules/terraform-aws-vpc"

  name                    = var.vpc_name
  cidr_block              = var.vpc_cidr_block
  availability_zones      = var.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
  tags                    = {}
}

module "terraform_aws_subnet_public" {
  source = "./modules/terraform-aws-subnet"

  name                            = var.public_subnet_name
  vpc_id                          = module.terraform_aws_vpc.vpc_id
  cidr_block                      = var.public_subnet_cidr_block
  availability_zone               = var.public_subnet_availability_zone
  map_public_ip_on_launch         = var.public_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block                 = var.public_subnet_ipv6_cidr_block
  create_route_table              = var.public_subnet_create_route_table
  default_route_target_id         = var.public_subnet_default_route_target_id
  default_route_target_type       = var.public_subnet_default_route_target_type
  additional_routes               = var.public_subnet_additional_routes
  tags                            = {}
}

module "terraform_aws_subnet_private" {
  source = "./modules/terraform-aws-subnet"

  name                            = var.private_subnet_name
  vpc_id                          = module.terraform_aws_vpc.vpc_id
  cidr_block                      = var.private_subnet_cidr_block
  availability_zone               = var.private_subnet_availability_zone
  map_public_ip_on_launch         = var.private_subnet_map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  ipv6_cidr_block                 = var.private_subnet_ipv6_cidr_block
  create_route_table              = var.private_subnet_create_route_table
  default_route_target_id         = var.private_subnet_default_route_target_id
  default_route_target_type       = var.private_subnet_default_route_target_type
  additional_routes               = var.private_subnet_additional_routes
  tags                            = {}
}

module "terraform_aws_s3" {
  source = "./modules/terraform-aws-s3"

  bucket_name             = var.bucket_name
  force_destroy           = var.force_destroy
  versioning_enabled      = var.versioning_enabled
  sse_algorithm           = var.sse_algorithm
  kms_master_key_id       = var.kms_master_key_id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  lifecycle_rules         = var.lifecycle_rules
  bucket_policy_json      = var.bucket_policy_json
  tags                    = {}
}
