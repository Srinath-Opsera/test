# CloudTrail Module
resource "aws_cloudtrail" "this" {
  name           = var.trail_name
  s3_bucket_name = var.s3_bucket_name
  s3_key_prefix  = var.s3_key_prefix

  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_logging                = var.enable_logging
  enable_log_file_validation    = var.enable_log_file_validation
  is_organization_trail         = var.is_organization_trail

  cloud_watch_logs_group_arn = var.cloudwatch_logs_group_arn
  cloud_watch_logs_role_arn  = var.cloudwatch_logs_role_arn
  kms_key_id                 = var.kms_key_id
  sns_topic_name             = var.sns_topic_name

  dynamic "event_selector" {
    for_each = var.event_selectors
    content {
      read_write_type                 = event_selector.value.read_write_type
      include_management_events       = event_selector.value.include_management_events
      exclude_management_event_sources = event_selector.value.exclude_management_event_sources

      dynamic "data_resource" {
        for_each = event_selector.value.data_resources
        content {
          type   = data_resource.value.type
          values = data_resource.value.values
        }
      }
    }
  }

  dynamic "insight_selector" {
    for_each = var.insight_selectors
    content {
      insight_type = insight_selector.value.insight_type
    }
  }

  tags = var.tags
}