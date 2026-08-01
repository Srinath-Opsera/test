output "role_id" {
  description = "Stable ID of the IAM role."
  value       = aws_iam_role.this.id
}

output "role_arn" {
  description = "ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "Name of the IAM role."
  value       = aws_iam_role.this.name
}

output "unique_id" {
  description = "Unique ID assigned by AWS."
  value       = aws_iam_role.this.unique_id
}
