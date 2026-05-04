# S3 Bucket outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3_bucket.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "s3_bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

# IAM Role outputs
output "iam_role_name" {
  description = "Name of the IAM role"
  value       = module.iam_role.role_name
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.iam_role.role_arn
}

# CloudTrail outputs
output "cloudtrail_id" {
  description = "ID of the CloudTrail"
  value       = module.cloudtrail.trail_id
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail"
  value       = module.cloudtrail.trail_arn
}

output "cloudtrail_name" {
  description = "Name of the CloudTrail"
  value       = module.cloudtrail.trail_name
}

output "cloudtrail_home_region" {
  description = "Region in which the trail was created"
  value       = module.cloudtrail.home_region
}