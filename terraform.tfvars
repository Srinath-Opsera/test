region       = "us-east-1"
service_name = "myapp"
team         = "platform"
environment  = "prod"

vpc_name                    = "myapp-prod"
vpc_cidr_block              = "10.0.0.0/16"
availability_zones          = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs         = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs        = ["10.0.2.0/24", "10.0.4.0/24"]
enable_nat_gateway          = true
single_nat_gateway          = true
enable_dns_hostnames        = true
enable_dns_support          = true
vpc_map_public_ip_on_launch = true

public_subnet_name                            = "public-myapp-prod"
public_subnet_cidr_block                      = "10.0.1.0/24"
public_subnet_availability_zone               = "us-east-1a"
public_subnet_map_public_ip_on_launch         = true
public_subnet_assign_ipv6_address_on_creation = false
public_subnet_ipv6_cidr_block                 = null
public_subnet_create_route_table              = true
public_subnet_default_route_target_id         = null
public_subnet_default_route_target_type       = "gateway_id"
public_subnet_additional_routes               = []

private_subnet_name                            = "private-myapp-prod"
private_subnet_cidr_block                      = "10.0.2.0/24"
private_subnet_availability_zone               = "us-east-1a"
private_subnet_map_public_ip_on_launch         = false
private_subnet_assign_ipv6_address_on_creation = false
private_subnet_ipv6_cidr_block                 = null
private_subnet_create_route_table              = true
private_subnet_default_route_target_id         = null
private_subnet_default_route_target_type       = "gateway_id"
private_subnet_additional_routes               = []

bucket_name             = "my-app-bucket-prod"
force_destroy           = false
versioning_enabled      = true
sse_algorithm           = "AES256"
kms_master_key_id       = null
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
lifecycle_rules         = []
bucket_policy_json      = null

default_tags = {
  Grupo = "platform"
  Entorno = "prod"
  Owner = "platform"
  Contacto = "platform"
  Terraform = "true"
  ManagedBy = "Opsera"
  Service = "myapp"
  NewRelic = "true"
}
