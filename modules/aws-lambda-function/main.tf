terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  function_name = var.function_name
  archive_file  = var.filename != null ? var.filename : null

  merged_tags = merge(
    var.tags,
    {
      "Name"        = var.function_name
      "Environment" = var.environment
    }
  )
}

# IAM Role for Lambda
resource "aws_iam_role" "this" {
  count = var.create_iam_role ? 1 : 0

  name                 = coalesce(var.iam_role_name, "${var.function_name}-role")
  description          = "IAM role for Lambda function ${var.function_name}"
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  permissions_boundary = var.permissions_boundary_arn

  tags = local.merged_tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  count = var.create_iam_role ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = var.vpc_subnet_ids != null ? "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole" : "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "additional" {
  for_each = var.create_iam_role ? toset(var.additional_policy_arns) : toset([])

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

resource "aws_iam_role_policy" "inline" {
  count = var.create_iam_role && var.inline_policy_json != null ? 1 : 0

  name   = "${var.function_name}-inline-policy"
  role   = aws_iam_role.this[0].id
  policy = var.inline_policy_json
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  count = var.create_cloudwatch_log_group ? 1 : 0

  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days
  kms_key_id        = var.log_kms_key_id

  tags = local.merged_tags
}

# Security Group for Lambda (VPC only)
resource "aws_security_group" "this" {
  count = var.create_security_group && var.vpc_subnet_ids != null ? 1 : 0

  name        = coalesce(var.security_group_name, "${var.function_name}-sg")
  description = "Security group for Lambda function ${var.function_name}"
  vpc_id      = var.vpc_id

  tags = merge(local.merged_tags, { "Name" = coalesce(var.security_group_name, "${var.function_name}-sg") })
}

resource "aws_security_group_rule" "egress" {
  count = var.create_security_group && var.vpc_subnet_ids != null ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this[0].id
  description       = "Allow all outbound traffic"
}

# Lambda Function
resource "aws_lambda_function" "this" {
  function_name = var.function_name
  description   = var.description
  role          = var.create_iam_role ? aws_iam_role.this[0].arn : var.existing_role_arn

  runtime       = var.runtime
  handler       = var.handler
  architectures = [var.architecture]

  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version
  source_code_hash  = var.source_code_hash
  image_uri         = var.image_uri
  package_type      = var.package_type

  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  layers = var.layer_arns

  publish = var.publish

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []
    content {
      variables = var.environment_variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null ? [1] : []
    content {
      subnet_ids = var.vpc_subnet_ids
      security_group_ids = concat(
        var.create_security_group ? [aws_security_group.this[0].id] : [],
        var.vpc_security_group_ids
      )
    }
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_target_arn != null ? [1] : []
    content {
      target_arn = var.dead_letter_target_arn
    }
  }

  dynamic "tracing_config" {
    for_each = var.tracing_mode != null ? [1] : []
    content {
      mode = var.tracing_mode
    }
  }

  dynamic "file_system_config" {
    for_each = var.file_system_arn != null ? [1] : []
    content {
      arn              = var.file_system_arn
      local_mount_path = var.file_system_local_mount_path
    }
  }

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size != null ? [1] : []
    content {
      size = var.ephemeral_storage_size
    }
  }

  dynamic "snap_start" {
    for_each = var.snap_start_enabled ? [1] : []
    content {
      apply_on = "PublishedVersions"
    }
  }

  kms_key_arn = var.kms_key_arn

  tags = local.merged_tags

  depends_on = [
    aws_iam_role_policy_attachment.basic_execution,
    aws_cloudwatch_log_group.this,
  ]
}

# Lambda Alias
resource "aws_lambda_alias" "this" {
  count = var.create_alias ? 1 : 0

  name             = var.alias_name
  description      = var.alias_description
  function_name    = aws_lambda_function.this.function_name
  function_version = var.alias_function_version != null ? var.alias_function_version : aws_lambda_function.this.version
}

# Lambda Function URL
resource "aws_lambda_function_url" "this" {
  count = var.create_function_url ? 1 : 0

  function_name      = aws_lambda_function.this.function_name
  qualifier          = var.create_alias ? aws_lambda_alias.this[0].name : null
  authorization_type = var.function_url_authorization_type

  dynamic "cors" {
    for_each = var.function_url_cors != null ? [var.function_url_cors] : []
    content {
      allow_credentials = lookup(cors.value, "allow_credentials", false)
      allow_headers     = lookup(cors.value, "allow_headers", null)
      allow_methods     = lookup(cors.value, "allow_methods", null)
      allow_origins     = lookup(cors.value, "allow_origins", null)
      expose_headers    = lookup(cors.value, "expose_headers", null)
      max_age           = lookup(cors.value, "max_age", null)
    }
  }
}

# Lambda Permission for triggers
resource "aws_lambda_permission" "this" {
  for_each = var.allowed_triggers

  statement_id       = each.key
  action             = "lambda:InvokeFunction"
  function_name      = aws_lambda_function.this.function_name
  principal          = each.value.principal
  source_arn         = lookup(each.value, "source_arn", null)
  source_account     = lookup(each.value, "source_account", null)
  qualifier          = var.create_alias ? aws_lambda_alias.this[0].name : null
  event_source_token = lookup(each.value, "event_source_token", null)
}

# Event Source Mappings (SQS, DynamoDB, Kinesis, etc.)
resource "aws_lambda_event_source_mapping" "this" {
  for_each = var.event_source_mappings

  event_source_arn                   = each.value.event_source_arn
  function_name                      = aws_lambda_function.this.function_name
  enabled                            = lookup(each.value, "enabled", true)
  batch_size                         = lookup(each.value, "batch_size", null)
  maximum_batching_window_in_seconds = lookup(each.value, "maximum_batching_window_in_seconds", null)
  starting_position                  = lookup(each.value, "starting_position", null)
  starting_position_timestamp        = lookup(each.value, "starting_position_timestamp", null)
  bisect_batch_on_function_error     = lookup(each.value, "bisect_batch_on_function_error", null)
  maximum_record_age_in_seconds      = lookup(each.value, "maximum_record_age_in_seconds", null)
  maximum_retry_attempts             = lookup(each.value, "maximum_retry_attempts", null)
  parallelization_factor             = lookup(each.value, "parallelization_factor", null)
  tumbling_window_in_seconds         = lookup(each.value, "tumbling_window_in_seconds", null)
  function_response_types            = lookup(each.value, "function_response_types", null)

  dynamic "destination_config" {
    for_each = lookup(each.value, "on_failure_destination_arn", null) != null ? [1] : []
    content {
      on_failure {
        destination_arn = each.value.on_failure_destination_arn
      }
    }
  }

  dynamic "filter_criteria" {
    for_each = lookup(each.value, "filter_patterns", null) != null ? [1] : []
    content {
      dynamic "filter" {
        for_each = each.value.filter_patterns
        content {
          pattern = filter.value
        }
      }
    }
  }
}
