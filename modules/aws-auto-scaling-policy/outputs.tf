output "id" {
  description = "ID of the Auto Scaling policy (same as name)."
  value       = aws_autoscaling_policy.this.id
}

output "name" {
  description = "Name of the Auto Scaling policy."
  value       = aws_autoscaling_policy.this.name
}

output "arn" {
  description = "ARN of the Auto Scaling policy."
  value       = aws_autoscaling_policy.this.arn
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling group the policy is attached to."
  value       = aws_autoscaling_policy.this.autoscaling_group_name
}

output "policy_type" {
  description = "Type of the Auto Scaling policy."
  value       = aws_autoscaling_policy.this.policy_type
}

output "adjustment_type" {
  description = "Adjustment type of the Auto Scaling policy."
  value       = aws_autoscaling_policy.this.adjustment_type
}
