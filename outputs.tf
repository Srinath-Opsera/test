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

output "alb_security_group_id" {
  value = module.security_group.security_group_id
}

output "alb_security_group_arn" {
  value = module.security_group.security_group_arn
}

output "ecs_security_group_id" {
  value = module.security_group_2.security_group_id
}

output "ecs_security_group_arn" {
  value = module.security_group_2.security_group_arn
}

output "public_subnet_id" {
  value = module.subnet.subnet_id
}

output "public_subnet_cidr_block" {
  value = module.subnet.subnet_cidr_block
}

output "private_subnet_id" {
  value = module.subnet_2.subnet_id
}

output "private_subnet_cidr_block" {
  value = module.subnet_2.subnet_cidr_block
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

output "lb_zone_id" {
  value = module.alb.lb_zone_id
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "https_listener_arn" {
  value = module.alb.https_listener_arn
}

output "log_group_names" {
  value = module.cloudwatch.log_group_names
}

output "log_group_arns" {
  value = module.cloudwatch.log_group_arns
}

output "role_id" {
  value = module.iam_role.role_id
}

output "role_arn" {
  value = module.iam_role.role_arn
}

output "role_name" {
  value = module.iam_role.role_name
}

output "cluster_id" {
  value = module.ecs_fargate.cluster_id
}

output "cluster_arn" {
  value = module.ecs_fargate.cluster_arn
}

output "service_id" {
  value = module.ecs_fargate.service_id
}

output "service_name" {
  value = module.ecs_fargate.service_name
}

output "task_definition_arn" {
  value = module.ecs_fargate.task_definition_arn
}

output "ecs_log_group_name" {
  value = module.ecs_fargate.log_group_name
}
