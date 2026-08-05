# ECR Repository Module

Creates an AWS Elastic Container Registry (ECR) repository with optional lifecycle policy, repository policy, and replication configuration.

## Usage


module "ecr" {
  source = "./modules/ecr"

  name                 = "my-app"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  encryption_type      = "KMS"
  kms_key_arn          = "arn:aws:kms:us-east-1:123456789012:key/abc123"
  force_delete         = false

  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 14 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 14
        }
        action = { type = "expire" }
      }
    ]
  })

  repository_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPush"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::123456789012:role/ci-role" }
        Action    = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage",
                     "ecr:BatchCheckLayerAvailability", "ecr:PutImage",
                     "ecr:InitiateLayerUpload", "ecr:UploadLayerPart",
                     "ecr:CompleteLayerUpload"]
      }
    ]
  })

  replication_destinations = [
    {
      region      = "us-west-2"
      registry_id = "123456789012"
    }
  ]

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the ECR repository | `string` | — | yes |
| image_tag_mutability | Tag mutability: MUTABLE or IMMUTABLE | `string` | `"IMMUTABLE"` | no |
| scan_on_push | Scan images on push | `bool` | `true` | no |
| encryption_type | AES256 or KMS (or null) | `string` | `"AES256"` | no |
| kms_key_arn | KMS key ARN (required when encryption_type = KMS) | `string` | `null` | no |
| force_delete | Delete repository even if it contains images | `bool` | `false` | no |
| lifecycle_policy | JSON lifecycle policy document | `string` | `null` | no |
| repository_policy | JSON repository policy document | `string` | `null` | no |
| replication_destinations | List of replication destinations (region, registry_id) | `list(object)` | `[]` | no |
| replication_filters | List of replication filters (filter, filter_type) | `list(object)` | `[]` | no |
| tags | Map of tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_name | Name of the ECR repository |
| repository_arn | ARN of the ECR repository |
| repository_url | URL used for docker push/pull |
| registry_id | AWS account ID of the registry |
| lifecycle_policy_id | ID of the lifecycle policy (if created) |
| repository_policy_id | ID of the repository policy (if created) |
