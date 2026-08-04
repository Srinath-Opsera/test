variable "log_groups" {
  description = "Map of CloudWatch log groups to create"
  type = map(object({
    name              = string
    retention_in_days = optional(number, 14)
    kms_key_id        = optional(string, null)
    tags              = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.log_groups : contains([
        1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653
      ], v.retention_in_days)
    ])
    error_message = "Retention in days must be a valid CloudWatch Logs retention period."
  }
}

variable "metric_alarms" {
  description = "Map of CloudWatch metric alarms to create"
  type = map(object({
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    alarm_description   = optional(string, "")
    alarm_actions       = optional(list(string), [])
    ok_actions         = optional(list(string), [])
    treat_missing_data  = optional(string, "missing")
    datapoints_to_alarm = optional(number, null)
    dimensions          = optional(map(string), null)
    unit               = optional(string, null)
    tags               = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.metric_alarms : contains([
        "GreaterThanOrEqualToThreshold",
        "GreaterThanThreshold",
        "LessThanThreshold",
        "LessThanOrEqualToThreshold"
      ], v.comparison_operator)
    ])
    error_message = "Comparison operator must be a valid CloudWatch comparison operator."
  }

  validation {
    condition = alltrue([
      for k, v in var.metric_alarms : contains([
        "SampleCount",
        "Average",
        "Sum",
        "Minimum",
        "Maximum"
      ], v.statistic)
    ])
    error_message = "Statistic must be a valid CloudWatch statistic."
  }

  validation {
    condition = alltrue([
      for k, v in var.metric_alarms : contains([
        "breaching",
        "notBreaching",
        "ignore",
        "missing"
      ], v.treat_missing_data)
    ])
    error_message = "Treat missing data must be a valid CloudWatch option."
  }
}

variable "dashboards" {
  description = "Map of CloudWatch dashboards to create"
  type = map(object({
    dashboard_name = string
    dashboard_body = string
  }))
  default = {}
}

variable "log_streams" {
  description = "Map of CloudWatch log streams to create"
  type = map(object({
    name           = string
    log_group_name = string
  }))
  default = {}
}

variable "event_rules" {
  description = "Map of CloudWatch event rules to create"
  type = map(object({
    name                = string
    description         = optional(string, "")
    event_pattern       = optional(string, null)
    schedule_expression = optional(string, null)
    state               = optional(string, "ENABLED")
    tags                = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.event_rules : contains(["ENABLED", "DISABLED"], v.state)
    ])
    error_message = "Event rule state must be either ENABLED or DISABLED."
  }

  validation {
    condition = alltrue([
      for k, v in var.event_rules : (
        (v.event_pattern != null && v.schedule_expression == null) ||
        (v.event_pattern == null && v.schedule_expression != null)
      )
    ])
    error_message = "Event rule must have either event_pattern or schedule_expression, but not both."
  }
}

variable "event_targets" {
  description = "Map of CloudWatch event targets to create"
  type = map(object({
    rule      = string
    target_id = string
    arn       = string
    role_arn  = optional(string, null)
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}