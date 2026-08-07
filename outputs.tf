output "vpc_id" {
  value = module.terraform_aws_vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.terraform_aws_vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  value = module.terraform_aws_vpc.internet_gateway_id
}

output "public_subnet_ids" {
  value = module.terraform_aws_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.terraform_aws_vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  value = module.terraform_aws_vpc.nat_gateway_ids
}

output "public_route_table_id" {
  value = module.terraform_aws_vpc.public_route_table_id
}

output "private_route_table_ids" {
  value = module.terraform_aws_vpc.private_route_table_ids
}

output "public_subnet_id" {
  value = module.terraform_aws_subnet_public.subnet_id
}

output "public_subnet_arn" {
  value = module.terraform_aws_subnet_public.subnet_arn
}

output "public_subnet_cidr_block" {
  value = module.terraform_aws_subnet_public.subnet_cidr_block
}

output "public_subnet_route_table_id" {
  value = module.terraform_aws_subnet_public.route_table_id
}

output "private_subnet_id" {
  value = module.terraform_aws_subnet_private.subnet_id
}

output "private_subnet_arn" {
  value = module.terraform_aws_subnet_private.subnet_arn
}

output "private_subnet_cidr_block" {
  value = module.terraform_aws_subnet_private.subnet_cidr_block
}

output "private_subnet_route_table_id" {
  value = module.terraform_aws_subnet_private.route_table_id
}

output "bucket_id" {
  value = module.terraform_aws_s3.bucket_id
}

output "bucket_arn" {
  value = module.terraform_aws_s3.bucket_arn
}

output "bucket_domain_name" {
  value = module.terraform_aws_s3.bucket_domain_name
}

output "bucket_regional_domain_name" {
  value = module.terraform_aws_s3.bucket_regional_domain_name
}
