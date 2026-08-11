output "log_group_names" {
  value = module.aws_cloudwatch.log_group_names
}

output "log_group_arns" {
  value = module.aws_cloudwatch.log_group_arns
}

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

output "security_group_id" {
  value = module.terraform_aws_security_group.security_group_id
}

output "security_group_arn" {
  value = module.terraform_aws_security_group.security_group_arn
}

output "subnet_id" {
  value = module.terraform_aws_subnet.subnet_id
}

output "subnet_arn" {
  value = module.terraform_aws_subnet.subnet_arn
}

output "subnet_cidr_block" {
  value = module.terraform_aws_subnet.subnet_cidr_block
}

output "function_name" {
  value = module.terraform_aws_lambda.function_name
}

output "function_arn" {
  value = module.terraform_aws_lambda.function_arn
}

output "function_invoke_arn" {
  value = module.terraform_aws_lambda.function_invoke_arn
}

output "role_arn" {
  value = module.terraform_aws_lambda.role_arn
}

output "log_group_name" {
  value = module.terraform_aws_lambda.log_group_name
}
