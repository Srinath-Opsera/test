output "log_group_names" {
  description = "Map of log group keys to their names"
  value       = { for k, v in aws_cloudwatch_log_group.this : k => v.name }
}

output "log_group_arns" {
  description = "Map of log group keys to their ARNs"
  value       = { for k, v in aws_cloudwatch_log_group.this : k => v.arn }
}

output "metric_alarm_arns" {
  description = "Map of metric alarm keys to their ARNs"
  value       = { for k, v in aws_cloudwatch_metric_alarm.this : k => v.arn }
}

output "metric_alarm_names" {
  description = "Map of metric alarm keys to their names"
  value       = { for k, v in aws_cloudwatch_metric_alarm.this : k => v.alarm_name }
}

output "dashboard_urls" {
  description = "Map of dashboard keys to their console URLs"
  value       = { for k, v in aws_cloudwatch_dashboard.this : k => v.dashboard_url }
}

output "log_stream_names" {
  description = "Map of log stream keys to their names"
  value       = { for k, v in aws_cloudwatch_log_stream.this : k => v.name }
}

output "log_stream_arns" {
  description = "Map of log stream keys to their ARNs"
  value       = { for k, v in aws_cloudwatch_log_stream.this : k => v.arn }
}

output "event_rule_arns" {
  description = "Map of event rule keys to their ARNs"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.arn }
}

output "event_rule_names" {
  description = "Map of event rule keys to their names"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.name }
}