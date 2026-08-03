# ECR Repository Module

This Terraform module creates an AWS Elastic Container Registry (ECR) repository with optional lifecycle policies, repository policies, image scanning, encryption, and cross-region replication.

## Usage

hcl
module "ecr" {
  source = "./modules/ecr"

  name                 = "my-app"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  encryption_type      = "KMS"
  kms_key_arn          = "arn:aws:kms:us-east-1:123456789012:key/mrk-abc123"
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
        Action    = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:PutImage"]
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
| name | The name of the ECR repository | `string` | — | yes |
| image_tag_mutability | Tag mutability: MUTABLE or IMMUTABLE | `string` | `"IMMUTABLE"` | no |
| scan_on_push | Enable image scanning on push | `bool` | `true` | no |
| encryption_type | Encryption type: AES256, KMS, or null | `string` | `"AES256"` | no |
| kms_key_arn | KMS key ARN (required when encryption_type is KMS) | `string` | `null` | no |
| force_delete | Delete repository even if it contains images | `bool` | `false` | no |
| lifecycle_policy | JSON-encoded lifecycle policy document | `string` | `null` | no |
| repository_policy | JSON-encoded repository policy document | `string` | `null` | no |
| replication_destinations | List of replication destinations (region, registry_id) | `list(object)` | `[]` | no |
| replication_filters | List of replication filters (filter, filter_type) | `list(object)` | `[]` | no |
| tags | Map of tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_arn | ARN of the ECR repository |
| repository_url | Full URL of the ECR repository |
| repository_name | Name of the ECR repository |
| registry_id | Registry ID where the repository was created |
| repository_id | ID of the ECR repository |
