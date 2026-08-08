region = "us-east-1"

name                       = "alb-affinity-test-staging"
vpc_id                     = ""
subnet_ids                 = []
security_group_ids         = []
certificate_arn            = ""
internal                   = false
enable_deletion_protection = false
idle_timeout               = 60
target_port                = 80
target_protocol            = "HTTP"
health_check_path          = "/"
ssl_policy                 = "ELBSecurityPolicy-2016-08"
additional_certificate_arns = []
alb_tags = {
  Name = "alb-affinity-test-staging"
}

ecr_name             = "ecr-affinity-test"
image_tag_mutability = "MUTABLE"
scan_on_push         = true
encryption_type      = "AES256"
kms_key_arn          = null
force_delete         = false
lifecycle_policy     = null
repository_policy    = null
replication_destinations = []
replication_filters      = []
ecr_tags = {
  Name = "ecr-affinity-test"
}

secret_name                       = "secret-affinity-test-staging"
description                       = null
secret_kms_key_id                 = null
recovery_window_in_days           = 30
force_overwrite_replica_secret    = false
replica_regions                   = []
secret_string                     = null
secret_binary                     = null
version_stages                    = null
enable_rotation                   = false
rotation_lambda_arn               = null
rotation_automatically_after_days = 30
secret_policy                     = null
block_public_policy               = true
secret_tags = {
  Name = "secret-affinity-test-staging"
}

service_name = "affinity-test"
team         = "platform"
environment  = "staging"
