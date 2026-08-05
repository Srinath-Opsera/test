variable "name" {
  description = "Name of the Auto Scaling policy."
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 255
    error_message = "The name must be between 1 and 255 characters."
  }
}

variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling group to attach the policy to."
  type        = string

  validation {
    condition     = length(var.autoscaling_group_name) > 0
    error_message = "The autoscaling_group_name must not be empty."
  }
}

variable "policy_type" {
  description = "Type of scaling policy. Valid values: SimpleScaling, StepScaling, TargetTrackingScaling, PredictiveScaling."
  type        = string
  default     = "SimpleScaling"

  validation {
    condition     = contains(["SimpleScaling", "StepScaling", "TargetTrackingScaling", "PredictiveScaling"], var.policy_type)
    error_message = "policy_type must be one of: SimpleScaling, StepScaling, TargetTrackingScaling, PredictiveScaling."
  }
}

variable "adjustment_type" {
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values: ChangeInCapacity, ExactCapacity, PercentChangeInCapacity. Required for SimpleScaling and StepScaling."
  type        = string
  default     = null

  validation {
    condition     = var.adjustment_type == null || contains(["ChangeInCapacity", "ExactCapacity", "PercentChangeInCapacity"], var.adjustment_type)
    error_message = "adjustment_type must be one of: ChangeInCapacity, ExactCapacity, PercentChangeInCapacity."
  }
}

variable "scaling_adjustment" {
  description = "Number of instances by which to scale. Required for SimpleScaling policy type."
  type        = number
  default     = null
}

variable "cooldown" {
  description = "Amount of time, in seconds, after a scaling activity completes before another can begin. Only applicable for SimpleScaling."
  type        = number
  default     = 300

  validation {
    condition     = var.cooldown == null || var.cooldown >= 0
    error_message = "cooldown must be a non-negative integer."
  }
}

variable "estimated_instance_warmup" {
  description = "Estimated time, in seconds, until a newly launched instance will contribute to CloudWatch metrics. Used with StepScaling and TargetTrackingScaling."
  type        = number
  default     = null

  validation {
    condition     = var.estimated_instance_warmup == null || var.estimated_instance_warmup >= 0
    error_message = "estimated_instance_warmup must be a non-negative integer."
  }
}

variable "min_adjustment_magnitude" {
  description = "Minimum number of instances to scale when adjustment_type is PercentChangeInCapacity."
  type        = number
  default     = null

  validation {
    condition     = var.min_adjustment_magnitude == null || var.min_adjustment_magnitude >= 1
    error_message = "min_adjustment_magnitude must be at least 1."
  }
}

variable "metric_aggregation_type" {
  description = "Aggregation type for CloudWatch metrics. Valid values: Minimum, Maximum, Average. Only applicable for StepScaling."
  type        = string
  default     = "Average"

  validation {
    condition     = contains(["Minimum", "Maximum", "Average"], var.metric_aggregation_type)
    error_message = "metric_aggregation_type must be one of: Minimum, Maximum, Average."
  }
}

variable "step_adjustments" {
  description = "List of step adjustment configurations for StepScaling policy. Each object must contain scaling_adjustment and optionally metric_interval_lower_bound and metric_interval_upper_bound."
  type = list(object({
    scaling_adjustment          = number
    metric_interval_lower_bound = optional(number)
    metric_interval_upper_bound = optional(number)
  }))
  default = []
}

variable "target_tracking_configuration" {
  description = "Target tracking configuration block for TargetTrackingScaling policy. Must include target_value and either predefined_metric_type or customized_metric_specification."
  type        = any
  default     = {}
}

variable "predictive_scaling_configuration" {
  description = "Predictive scaling configuration block for PredictiveScaling policy. Must include metric_specification with target_value."
  type        = any
  default     = {}
}

variable "tags" {
  description = "Map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
