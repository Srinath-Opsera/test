output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
}

output "internet_gateway_resource_id" {
  value = module.internet_gateway.id
}

output "public_subnet_id" {
  value = module.public_subnet.subnet_id
}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id
}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

output "nat_gateway_public_ip" {
  value = module.nat_gateway.nat_gateway_public_ip
}

output "security_group_alb_id" {
  value = module.security_group_alb.security_group_id
}

output "security_group_ecs_id" {
  value = module.security_group_ecs.security_group_id
}

output "security_group_lambda_id" {
  value = module.security_group_lambda.security_group_id
}

output "lb_id" {
  value = module.alb.lb_id
}

output "lb_arn" {
  value = module.alb.lb_arn
}

output "lb_dns_name" {
  value = module.alb.lb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "log_group_names" {
  value = module.cloudwatch.log_group_names
}

output "log_group_arns" {
  value = module.cloudwatch.log_group_arns
}

output "ecr_repository_name" {
  value = module.ecr_repository.repository_name
}

output "ecr_repository_url" {
  value = module.ecr_repository.repository_url
}

output "ecr_repository_arn" {
  value = module.ecr_repository.repository_arn
}

output "iam_role_ecs_arn" {
  value = module.iam_role_ecs.role_arn
}

output "iam_role_ecs_name" {
  value = module.iam_role_ecs.role_name
}

output "iam_role_lambda_arn" {
  value = module.iam_role_lambda.role_arn
}

output "iam_role_lambda_name" {
  value = module.iam_role_lambda.role_name
}

output "ecs_cluster_id" {
  value = module.ecs_fargate.cluster_id
}

output "ecs_cluster_arn" {
  value = module.ecs_fargate.cluster_arn
}

output "ecs_service_id" {
  value = module.ecs_fargate.service_id
}

output "ecs_service_name" {
  value = module.ecs_fargate.service_name
}

output "ecs_task_definition_arn" {
  value = module.ecs_fargate.task_definition_arn
}

output "lambda_function_name" {
  value = module.lambda_function.function_name
}

output "lambda_function_arn" {
  value = module.lambda_function.function_arn
}

output "lambda_function_invoke_arn" {
  value = module.lambda_function.function_invoke_arn
}

output "lambda_role_arn" {
  value = module.lambda_function.role_arn
}

output "secret_id" {
  value = module.secrets_manager.secret_id
}

output "secret_arn" {
  value = module.secrets_manager.secret_arn
}

output "secret_name" {
  value = module.secrets_manager.secret_name
}
