# ECR Repository Module

This Terraform module creates an AWS Elastic Container Registry (ECR) repository with optional lifecycle policies, repository policies, and registry-level scanning configuration.

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
        Principal = { AWS = "arn:aws:iam::123456789012:role/my-role" }
        Action    = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability", "ecr:PutImage", "ecr:InitiateLayerUpload", "ecr:UploadLayerPart", "ecr:CompleteLayerUpload"]
      }
    ]
  })

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
| scan_on_push | Scan images on push | `bool` | `true` | no |
| encryption_type | Encryption type: AES256 or KMS | `string` | `"AES256"` | no |
| kms_key_arn | KMS key ARN (required when encryption_type is KMS) | `string` | `null` | no |
| force_delete | Delete repository even if it contains images | `bool` | `false` | no |
| lifecycle_policy | JSON-encoded lifecycle policy document | `string` | `null` | no |
| repository_policy | JSON-encoded repository policy document | `string` | `null` | no |
| enable_registry_scanning | Configure registry-level scanning | `bool` | `false` | no |
| registry_scan_type | Registry scan type: BASIC or ENHANCED | `string` | `"BASIC"` | no |
| registry_scan_rules | List of registry scanning rules | `list(object)` | `[]` | no |
| tags | Map of tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_name | The name of the ECR repository |
| repository_arn | The ARN of the ECR repository |
| repository_url | The URL for docker push/pull |
| repository_id | The registry ID |
| lifecycle_policy_id | The lifecycle policy resource ID |
| repository_policy_id | The repository policy resource ID |
