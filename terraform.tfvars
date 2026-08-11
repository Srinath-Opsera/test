# Base template — per-environment files are generated below.
# Environments: staging, auto

region = "us-east-1"

terraform_aws_vpc__virtual_private_cloud_vpc__name                    = "affinity-test-staging"
terraform_aws_vpc__virtual_private_cloud_vpc__availability_zones      = ["us-east-1a", "us-east-1b"]
terraform_aws_vpc__virtual_private_cloud_vpc__public_subnet_cidrs     = ["10.0.0.0/24", "10.0.1.0/24"]
terraform_aws_vpc__virtual_private_cloud_vpc__private_subnet_cidrs    = ["10.0.2.0/24", "10.0.3.0/24"]
terraform_aws_vpc__virtual_private_cloud_vpc__cidr_block              = "10.0.0.0/16"
terraform_aws_vpc__virtual_private_cloud_vpc__enable_nat_gateway      = true
terraform_aws_vpc__virtual_private_cloud_vpc__single_nat_gateway      = true
terraform_aws_vpc__virtual_private_cloud_vpc__enable_dns_hostnames    = true
terraform_aws_vpc__virtual_private_cloud_vpc__enable_dns_support      = true
terraform_aws_vpc__virtual_private_cloud_vpc__map_public_ip_on_launch = true

terraform_aws_subnet__public_subnet__name                            = "affinity-test-staging"
terraform_aws_subnet__public_subnet__cidr_block                      = "10.0.1.0/24"
terraform_aws_subnet__public_subnet__availability_zone               = "us-east-1a"
terraform_aws_subnet__public_subnet__map_public_ip_on_launch         = true
terraform_aws_subnet__public_subnet__assign_ipv6_address_on_creation = false
terraform_aws_subnet__public_subnet__ipv6_cidr_block                 = null
terraform_aws_subnet__public_subnet__create_route_table              = true
terraform_aws_subnet__public_subnet__default_route_target_id         = null
terraform_aws_subnet__public_subnet__default_route_target_type       = "gateway_id"
terraform_aws_subnet__public_subnet__additional_routes               = []

terraform_aws_subnet__private_subnet__name                            = "affinity-test-staging"
terraform_aws_subnet__private_subnet__cidr_block                      = "10.0.2.0/24"
terraform_aws_subnet__private_subnet__availability_zone               = "us-east-1a"
terraform_aws_subnet__private_subnet__map_public_ip_on_launch         = false
terraform_aws_subnet__private_subnet__assign_ipv6_address_on_creation = false
terraform_aws_subnet__private_subnet__ipv6_cidr_block                 = null
terraform_aws_subnet__private_subnet__create_route_table              = true
terraform_aws_subnet__private_subnet__default_route_target_id         = null
terraform_aws_subnet__private_subnet__default_route_target_type       = "nat_gateway_id"
terraform_aws_subnet__private_subnet__additional_routes               = []

terraform_aws_security_group__alb_security_group__name                    = "affinity-test-staging"
terraform_aws_security_group__alb_security_group__description             = "Managed by Terraform"
terraform_aws_security_group__alb_security_group__ingress_rules           = [
  {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  },
  {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]
terraform_aws_security_group__alb_security_group__egress_rules            = [
  {
    description      = ""
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]
terraform_aws_security_group__alb_security_group__default_egress_allow_all = true
terraform_aws_security_group__alb_security_group__revoke_rules_on_delete   = false

terraform_aws_security_group__ecs_security_group__name                    = "affinity-test-staging"
terraform_aws_security_group__ecs_security_group__description             = "Managed by Terraform"
terraform_aws_security_group__ecs_security_group__ingress_rules           = [
  {
    description      = "Allow traffic from ALB"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]
terraform_aws_security_group__ecs_security_group__egress_rules            = []
terraform_aws_security_group__ecs_security_group__default_egress_allow_all = true
terraform_aws_security_group__ecs_security_group__revoke_rules_on_delete   = false

terraform_aws_security_group__lambda_security_group__name                    = "affinity-test-staging"
terraform_aws_security_group__lambda_security_group__description             = "Managed by Terraform"
terraform_aws_security_group__lambda_security_group__ingress_rules           = []
terraform_aws_security_group__lambda_security_group__egress_rules            = []
terraform_aws_security_group__lambda_security_group__default_egress_allow_all = true
terraform_aws_security_group__lambda_security_group__revoke_rules_on_delete   = false

terraform_aws_security_group__rds_security_group__name                    = "affinity-test-staging"
terraform_aws_security_group__rds_security_group__description             = "Security group for RDS Aurora PostgreSQL"
terraform_aws_security_group__rds_security_group__ingress_rules           = [
  {
    description      = "PostgreSQL from ECS"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  },
  {
    description      = "PostgreSQL from Lambda"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]
terraform_aws_security_group__rds_security_group__egress_rules            = []
terraform_aws_security_group__rds_security_group__default_egress_allow_all = true
terraform_aws_security_group__rds_security_group__revoke_rules_on_delete   = false

terraform_aws_alb__application_load_balancer__name                       = "affinity-test-staging"
terraform_aws_alb__application_load_balancer__certificate_arn            = ""
terraform_aws_alb__application_load_balancer__internal                   = false
terraform_aws_alb__application_load_balancer__enable_deletion_protection = false
terraform_aws_alb__application_load_balancer__idle_timeout               = 60
terraform_aws_alb__application_load_balancer__target_port                = 8080
terraform_aws_alb__application_load_balancer__target_protocol            = "HTTP"
terraform_aws_alb__application_load_balancer__health_check_path          = "/"
terraform_aws_alb__application_load_balancer__ssl_policy                 = "ELBSecurityPolicy-2016-08"
terraform_aws_alb__application_load_balancer__additional_certificate_arns = []

terraform_aws_iam_role__ecs_task_iam_role__name                   = "affinity-test-staging"
terraform_aws_iam_role__ecs_task_iam_role__assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["ecs-tasks.amazonaws.com"]
  }
]
terraform_aws_iam_role__ecs_task_iam_role__description            = ""
terraform_aws_iam_role__ecs_task_iam_role__path                   = "/"
terraform_aws_iam_role__ecs_task_iam_role__max_session_duration   = 3600
terraform_aws_iam_role__ecs_task_iam_role__managed_policy_arns    = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
terraform_aws_iam_role__ecs_task_iam_role__inline_policies        = {}
terraform_aws_iam_role__ecs_task_iam_role__permissions_boundary   = null
terraform_aws_iam_role__ecs_task_iam_role__force_detach_policies  = true

terraform_aws_iam_role__lambda_iam_role__name                   = "affinity-test-staging"
terraform_aws_iam_role__lambda_iam_role__assume_role_principals = [
  {
    type        = "Service"
    identifiers = ["lambda.amazonaws.com"]
  }
]
terraform_aws_iam_role__lambda_iam_role__description            = ""
terraform_aws_iam_role__lambda_iam_role__path                   = "/"
terraform_aws_iam_role__lambda_iam_role__max_session_duration   = 3600
terraform_aws_iam_role__lambda_iam_role__managed_policy_arns    = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
terraform_aws_iam_role__lambda_iam_role__inline_policies        = {}
terraform_aws_iam_role__lambda_iam_role__permissions_boundary   = null
terraform_aws_iam_role__lambda_iam_role__force_detach_policies  = true

terraform_aws_ecs_fargate__ecs_cluster__cluster_name           = "affinity-test-staging"
terraform_aws_ecs_fargate__ecs_cluster__service_name           = "test"
terraform_aws_ecs_fargate__ecs_cluster__task_family            = "affinity-test-staging"
terraform_aws_ecs_fargate__ecs_cluster__container_name         = "affinity-test-staging"
terraform_aws_ecs_fargate__ecs_cluster__container_image        = "{accountId}.dkr.ecr.us-east-1.amazonaws.com/ecr-affinity-test-staging:latest"
terraform_aws_ecs_fargate__ecs_cluster__cpu                    = 256
terraform_aws_ecs_fargate__ecs_cluster__memory                 = 512
terraform_aws_ecs_fargate__ecs_cluster__container_port         = 8080
terraform_aws_ecs_fargate__ecs_cluster__desired_count          = 1
terraform_aws_ecs_fargate__ecs_cluster__assign_public_ip       = false
terraform_aws_ecs_fargate__ecs_cluster__enable_autoscaling     = false
terraform_aws_ecs_fargate__ecs_cluster__autoscaling_min        = 1
terraform_aws_ecs_fargate__ecs_cluster__autoscaling_max        = 4
terraform_aws_ecs_fargate__ecs_cluster__autoscaling_cpu_target = 70
terraform_aws_ecs_fargate__ecs_cluster__log_retention_days     = 30

terraform_aws_ecs_fargate__ecs_fargate_service__cluster_name           = "affinity-test-staging"
terraform_aws_ecs_fargate__ecs_fargate_service__service_name           = "test"
terraform_aws_ecs_fargate__ecs_fargate_service__task_family            = "affinity-test-staging"
terraform_aws_ecs_fargate__ecs_fargate_service__container_name         = "affinity-test-staging"
terraform_aws_ecs_fargate__ecs_fargate_service__container_image        = "{accountId}.dkr.ecr.us-east-1.amazonaws.com/ecr-affinity-test-staging:latest"
terraform_aws_ecs_fargate__ecs_fargate_service__cpu                    = 256
terraform_aws_ecs_fargate__ecs_fargate_service__memory                 = 512
terraform_aws_ecs_fargate__ecs_fargate_service__container_port         = 8080
terraform_aws_ecs_fargate__ecs_fargate_service__desired_count          = 1
terraform_aws_ecs_fargate__ecs_fargate_service__assign_public_ip       = false
terraform_aws_ecs_fargate__ecs_fargate_service__enable_autoscaling     = false
terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_min        = 1
terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_max        = 4
terraform_aws_ecs_fargate__ecs_fargate_service__autoscaling_cpu_target = 70
terraform_aws_ecs_fargate__ecs_fargate_service__log_retention_days     = 30

terraform_aws_rds__rds_aurora_postgresql__identifier            = "affinity-test-staging"
terraform_aws_rds__rds_aurora_postgresql__engine                = "aurora-postgresql"
terraform_aws_rds__rds_aurora_postgresql__engine_version        = "15.4"
terraform_aws_rds__rds_aurora_postgresql__username              = "affinity-test-staging"
terraform_aws_rds__rds_aurora_postgresql__password              = ""
terraform_aws_rds__rds_aurora_postgresql__db_subnet_group_name  = "affinity-test-staging"
terraform_aws_rds__rds_aurora_postgresql__instance_class        = "db.t3.medium"
terraform_aws_rds__rds_aurora_postgresql__allocated_storage     = 20
terraform_aws_rds__rds_aurora_postgresql__max_allocated_storage = 0
terraform_aws_rds__rds_aurora_postgresql__storage_type          = "gp3"
terraform_aws_rds__rds_aurora_postgresql__storage_encrypted     = true
terraform_aws_rds__rds_aurora_postgresql__kms_key_id            = null
terraform_aws_rds__rds_aurora_postgresql__db_name               = "affinity-test-staging"
terraform_aws_rds__rds_aurora_postgresql__multi_az              = false
terraform_aws_rds__rds_aurora_postgresql__backup_retention_period = 7
terraform_aws_rds__rds_aurora_postgresql__deletion_protection   = false
terraform_aws_rds__rds_aurora_postgresql__skip_final_snapshot   = true

terraform_aws_s3__s3_bucket__bucket_name            = "affinity-test-staging"
terraform_aws_s3__s3_bucket__force_destroy          = false
terraform_aws_s3__s3_bucket__versioning_enabled     = true
terraform_aws_s3__s3_bucket__sse_algorithm          = "AES256"
terraform_aws_s3__s3_bucket__kms_master_key_id      = null
terraform_aws_s3__s3_bucket__block_public_acls      = true
terraform_aws_s3__s3_bucket__block_public_policy    = true
terraform_aws_s3__s3_bucket__ignore_public_acls     = true
terraform_aws_s3__s3_bucket__restrict_public_buckets = true
terraform_aws_s3__s3_bucket__lifecycle_rules        = []
terraform_aws_s3__s3_bucket__bucket_policy_json     = null

aws_secrets_manager__name                              = "affinity-test-staging"
aws_secrets_manager__description                       = null
aws_secrets_manager__kms_key_id                        = null
aws_secrets_manager__recovery_window_in_days           = 30
aws_secrets_manager__secret_string                     = null
aws_secrets_manager__secret_key_value_pairs            = {}
aws_secrets_manager__secret_binary                     = null
aws_secrets_manager__enable_rotation                   = false
aws_secrets_manager__rotation_lambda_arn               = null
aws_secrets_manager__rotation_automatically_after_days = 30
aws_secrets_manager__block_public_policy               = true

aws_cloudwatch__cloudwatch_alarms__log_groups = {
  "affinity-test-staging" = {
    name              = "/aws/ecs/affinity-test-staging"
    retention_in_days = 30
    kms_key_id        = null
    tags              = {}
  }
}
aws_cloudwatch__cloudwatch_alarms__metric_alarms = {}
aws_cloudwatch__cloudwatch_alarms__dashboards    = {}
aws_cloudwatch__cloudwatch_alarms__log_streams   = {}
aws_cloudwatch__cloudwatch_alarms__event_rules   = {}
aws_cloudwatch__cloudwatch_alarms__event_targets = {}

aws_cloudwatch__cloudwatch_log_group__log_groups = {
  "affinity-test-staging" = {
    name              = "/affinity/test/staging"
    retention_in_days = 30
    kms_key_id        = null
    tags              = {}
  }
}
aws_cloudwatch__cloudwatch_log_group__metric_alarms = {}
aws_cloudwatch__cloudwatch_log_group__dashboards    = {}
aws_cloudwatch__cloudwatch_log_group__log_streams   = {}
aws_cloudwatch__cloudwatch_log_group__event_rules   = {}
aws_cloudwatch__cloudwatch_log_group__event_targets = {}
service_name = "test"
team = "affinity"
environment = "{env}"
