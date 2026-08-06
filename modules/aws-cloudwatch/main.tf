# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "this" {
  for_each = var.log_groups

  name              = each.value.name
  retention_in_days = each.value.retention_in_days
  kms_key_id        = each.value.kms_key_id

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.value.name
    }
  )
}

# CloudWatch Metric Alarms
resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = var.metric_alarms

  alarm_name          = each.value.alarm_name
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold
  alarm_description   = each.value.alarm_description
  alarm_actions       = each.value.alarm_actions
  ok_actions          = each.value.ok_actions
  treat_missing_data  = each.value.treat_missing_data
  datapoints_to_alarm = each.value.datapoints_to_alarm
  unit                = each.value.unit

  dimensions = each.value.dimensions

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.value.alarm_name
    }
  )
}

# CloudWatch Dashboards
resource "aws_cloudwatch_dashboard" "this" {
  for_each = var.dashboards

  dashboard_name = each.value.dashboard_name
  dashboard_body = each.value.dashboard_body
}

# CloudWatch Log Streams
resource "aws_cloudwatch_log_stream" "this" {
  for_each = var.log_streams

  name           = each.value.name
  log_group_name = each.value.log_group_name

  depends_on = [aws_cloudwatch_log_group.this]
}

# CloudWatch Event Rules
resource "aws_cloudwatch_event_rule" "this" {
  for_each = var.event_rules

  name                = each.value.name
  description         = each.value.description
  event_pattern       = each.value.event_pattern
  schedule_expression = each.value.schedule_expression
  state               = each.value.state

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.value.name
    }
  )
}

# CloudWatch Event Targets
resource "aws_cloudwatch_event_target" "this" {
  for_each = var.event_targets

  rule      = each.value.rule
  target_id = each.value.target_id
  arn       = each.value.arn
  role_arn  = each.value.role_arn

  depends_on = [aws_cloudwatch_event_rule.this]
}
