# CloudTrail Module

This module creates an AWS CloudTrail for logging API calls and events across your AWS infrastructure.

## Features

- Multi-region trail support
- CloudWatch Logs integration
- S3 bucket delivery
- Event and insight selectors
- KMS encryption support
- SNS notifications
- Log file validation
- Organization trail support

## Usage

hcl
module "cloudtrail" {
  source = "./modules/cloudtrail"

  trail_name     = "my-cloudtrail"
  s3_bucket_name = "my-cloudtrail-logs"
  s3_key_prefix  = "cloudtrail-logs/"
  
  is_multi_region_trail = true
  enable_logging        = true
  
  kms_key_id                = aws_kms_key.cloudtrail.arn
  cloudwatch_logs_group_arn = aws_cloudwatch_log_group.cloudtrail.arn
  cloudwatch_logs_role_arn  = aws_iam_role.cloudtrail_logs.arn
  
  event_selectors = [
    {
      read_write_type           = "All"
      include_management_events = true
      data_resources = [
        {
          type   = "AWS::S3::Object"
          values = ["arn:aws:s3:::my-bucket/*"]
        }
      ]
    }
  ]
  
  tags = {
    Environment = "production"
    Owner       = "security-team"
  }
}


## Requirements

| Name | Version |
|------|---------|  
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| trail_name | Name of the CloudTrail | `string` | n/a | yes |
| s3_bucket_name | S3 bucket for log delivery | `string` | n/a | yes |
| is_multi_region_trail | Multi-region trail | `bool` | `true` | no |
| enable_logging | Enable logging | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| trail_id | CloudTrail ID |
| trail_arn | CloudTrail ARN |
| trail_name | CloudTrail name |
| home_region | Trail home region |