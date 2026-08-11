terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  dynamic "encryption_configuration" {
    for_each = var.encryption_type != null ? [1] : []
    content {
      encryption_type = var.encryption_type
      kms_key         = var.encryption_type == "KMS" ? var.kms_key_arn : null
    }
  }

  force_delete = var.force_delete

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  count = var.lifecycle_policy != null ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy
}

resource "aws_ecr_repository_policy" "this" {
  count = var.repository_policy != null ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy     = var.repository_policy
}

resource "aws_ecr_replication_configuration" "this" {
  count = length(var.replication_destinations) > 0 ? 1 : 0

  replication_configuration {
    rule {
      dynamic "destination" {
        for_each = var.replication_destinations
        content {
          region      = destination.value.region
          registry_id = destination.value.registry_id
        }
      }

      dynamic "repository_filter" {
        for_each = var.replication_filters
        content {
          filter      = repository_filter.value.filter
          filter_type = repository_filter.value.filter_type
        }
      }
    }
  }
}
