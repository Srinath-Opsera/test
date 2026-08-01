terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

data "aws_iam_policy_document" "assume" {
  dynamic "statement" {
    for_each = var.assume_role_principals
    content {
      actions = ["sts:AssumeRole"]
      principals {
        type        = statement.value.type
        identifiers = statement.value.identifiers
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.name
  description          = var.description
  path                 = var.path
  max_session_duration = var.max_session_duration
  assume_role_policy   = data.aws_iam_policy_document.assume.json
  permissions_boundary = var.permissions_boundary
  force_detach_policies = var.force_detach_policies

  tags = merge(var.tags, { Name = var.name })
}

resource "aws_iam_role_policy_attachment" "managed" {
  count = length(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = var.managed_policy_arns[count.index]
}

resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies

  name   = each.value.name
  role   = aws_iam_role.this.id
  policy = each.value.policy
}
