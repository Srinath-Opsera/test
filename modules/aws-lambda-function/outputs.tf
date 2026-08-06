output "function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.this.arn
}

output "function_qualified_arn" {
  description = "The qualified ARN of the Lambda function (includes version)."
  value       = aws_lambda_function.this.qualified_arn
}

output "function_invoke_arn" {
  description = "The ARN to be used for invoking the Lambda function from API Gateway."
  value       = aws_lambda_function.this.invoke_arn
}

output "function_version" {
  description = "The latest published version of the Lambda function."
  value       = aws_lambda_function.this.version
}

output "function_last_modified" {
  description = "The date the Lambda function was last modified."
  value       = aws_lambda_function.this.last_modified
}

output "iam_role_arn" {
  description = "The ARN of the IAM execution role for the Lambda function."
  value       = var.create_iam_role ? aws_iam_role.this[0].arn : var.existing_iam_role_arn
}

output "iam_role_name" {
  description = "The name of the IAM execution role for the Lambda function."
  value       = var.create_iam_role ? aws_iam_role.this[0].name : null
}

output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group for the Lambda function."
  value       = var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[0].name : "/aws/lambda/${aws_lambda_function.this.function_name}"
}

output "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group for the Lambda function."
  value       = var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[0].arn : null
}

output "security_group_id" {
  description = "The ID of the security group created for the Lambda function."
  value       = var.create_security_group && var.vpc_subnet_ids != null ? aws_security_group.this[0].id : null
}

output "alias_arns" {
  description = "Map of Lambda alias names to their ARNs."
  value       = { for k, v in aws_lambda_alias.this : k => v.arn }
}

output "alias_invoke_arns" {
  description = "Map of Lambda alias names to their invoke ARNs."
  value       = { for k, v in aws_lambda_alias.this : k => v.invoke_arn }
}

output "function_url" {
  description = "The HTTPS URL endpoint for the Lambda function URL."
  value       = var.create_function_url ? aws_lambda_function_url.this[0].function_url : null
}

output "function_url_id" {
  description = "The unique identifier for the Lambda function URL."
  value       = var.create_function_url ? aws_lambda_function_url.this[0].url_id : null
}

output "event_source_mapping_ids" {
  description = "Map of event source mapping keys to their UUIDs."
  value       = { for k, v in aws_lambda_event_source_mapping.this : k => v.uuid }
}
