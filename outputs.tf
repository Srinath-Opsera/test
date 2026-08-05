output "vpc_id" {
  description = "ID of the VPC"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = module.aws-internet-gateway.id
}

output "nat_gateway_ids" {
  description = "IDs of the NAT gateways"
  value       = module.aws-nat-gateway.nat_gateway_ids
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.terraform-aws-subnet--public-subnet.subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.terraform-aws-subnet--private-subnet.subnet_id
}

output "vpc_public_subnet_ids" {
  description = "IDs of public subnets from VPC module"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.public_subnet_ids
}

output "vpc_private_subnet_ids" {
  description = "IDs of private subnets from VPC module"
  value       = module.terraform-aws-vpc--virtual-private-cloud-vpc.private_subnet_ids
}

output "alb_sg_id" {
  description = "ID of the ALB security group"
  value       = module.terraform-aws-security-group--alb-security-group.security_group_id
}

output "ecs_sg_id" {
  description = "ID of the ECS security group"
  value       = module.terraform-aws-security-group--ecs-security-group.security_group_id
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.terraform-aws-alb--application-load-balancer.lb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.terraform-aws-alb--application-load-balancer.lb_arn
}

output "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  value       = module.terraform-aws-alb--application-load-balancer.target_group_arn
}

output "alb_https_listener_arn" {
  description = "ARN of the ALB HTTPS listener"
  value       = module.terraform-aws-alb--application-load-balancer.https_listener_arn
}

output "cloudwatch_log_group_names" {
  description = "CloudWatch log group names"
  value       = module.aws-cloudwatch--cloudwatch-log-group.log_group_names
}

output "cloudwatch_log_group_arns" {
  description = "CloudWatch log group ARNs"
  value       = module.aws-cloudwatch--cloudwatch-log-group.log_group_arns
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.aws-ecr-repository.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.aws-ecr-repository.repository_arn
}

output "ecs_exec_role_arn" {
  description = "ARN of the ECS task execution IAM role"
  value       = module.terraform-aws-iam-role--ecs-task-execution-iam-role.role_arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task IAM role"
  value       = module.terraform-aws-iam-role--ecs-task-iam-role.role_arn
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.cluster_id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.cluster_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.task_definition_arn
}

output "ecs_log_group_name" {
  description = "CloudWatch log group for ECS tasks"
  value       = module.terraform-aws-ecs-fargate--ecs-cluster.log_group_name
}

output "asg_policy_arn" {
  description = "ARN of the auto scaling policy"
  value       = module.aws-auto-scaling-policy.arn
}
