output "trail_id" {
  description = "Name of the CloudTrail"
  value       = aws_cloudtrail.this.id
}

output "trail_arn" {
  description = "ARN of the CloudTrail"
  value       = aws_cloudtrail.this.arn
}

output "trail_name" {
  description = "Name of the CloudTrail"
  value       = aws_cloudtrail.this.name
}

output "home_region" {
  description = "Region in which the trail was created"
  value       = aws_cloudtrail.this.home_region
}