terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_autoscaling_policy" "this" {
  name                   = var.name
  autoscaling_group_name = var.autoscaling_group_name
  policy_type            = var.policy_type
  adjustment_type        = var.policy_type == "SimpleScaling" || var.policy_type == "StepScaling" ? var.adjustment_type : null
  cooldown               = var.policy_type == "SimpleScaling" ? var.cooldown : null
  estimated_instance_warmup = var.policy_type != "SimpleScaling" ? var.estimated_instance_warmup : null
  min_adjustment_magnitude  = contains(["PercentChangeInCapacity"], coalesce(var.adjustment_type, "none")) ? var.min_adjustment_magnitude : null

  scaling_adjustment = var.policy_type == "SimpleScaling" ? var.scaling_adjustment : null
  metric_aggregation_type = var.policy_type == "StepScaling" ? var.metric_aggregation_type : null

  dynamic "step_adjustment" {
    for_each = var.policy_type == "StepScaling" ? var.step_adjustments : []
    content {
      scaling_adjustment          = step_adjustment.value.scaling_adjustment
      metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
      metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
    }
  }

  dynamic "target_tracking_configuration" {
    for_each = var.policy_type == "TargetTrackingScaling" ? [var.target_tracking_configuration] : []
    content {
      target_value     = target_tracking_configuration.value.target_value
      disable_scale_in = lookup(target_tracking_configuration.value, "disable_scale_in", false)

      dynamic "predefined_metric_specification" {
        for_each = lookup(target_tracking_configuration.value, "predefined_metric_type", null) != null ? [1] : []
        content {
          predefined_metric_type = target_tracking_configuration.value.predefined_metric_type
          resource_label         = lookup(target_tracking_configuration.value, "resource_label", null)
        }
      }

      dynamic "customized_metric_specification" {
        for_each = lookup(target_tracking_configuration.value, "customized_metric_specification", null) != null ? [target_tracking_configuration.value.customized_metric_specification] : []
        content {
          metric_name = customized_metric_specification.value.metric_name
          namespace   = customized_metric_specification.value.namespace
          statistic   = customized_metric_specification.value.statistic
          unit        = lookup(customized_metric_specification.value, "unit", null)

          dynamic "metric_dimension" {
            for_each = lookup(customized_metric_specification.value, "metric_dimensions", [])
            content {
              name  = metric_dimension.value.name
              value = metric_dimension.value.value
            }
          }
        }
      }
    }
  }

  dynamic "predictive_scaling_configuration" {
    for_each = var.policy_type == "PredictiveScaling" ? [var.predictive_scaling_configuration] : []
    content {
      max_capacity_breach_behavior = lookup(predictive_scaling_configuration.value, "max_capacity_breach_behavior", "HonorMaxCapacity")
      max_capacity_buffer          = lookup(predictive_scaling_configuration.value, "max_capacity_buffer", null)
      mode                         = lookup(predictive_scaling_configuration.value, "mode", "ForecastOnly")
      scheduling_buffer_time       = lookup(predictive_scaling_configuration.value, "scheduling_buffer_time", null)

      dynamic "metric_specification" {
        for_each = [predictive_scaling_configuration.value.metric_specification]
        content {
          target_value = metric_specification.value.target_value

          dynamic "predefined_load_metric_specification" {
            for_each = lookup(metric_specification.value, "predefined_load_metric_specification", null) != null ? [metric_specification.value.predefined_load_metric_specification] : []
            content {
              predefined_metric_type = predefined_load_metric_specification.value.predefined_metric_type
              resource_label         = predefined_load_metric_specification.value.resource_label
            }
          }

          dynamic "predefined_metric_pair_specification" {
            for_each = lookup(metric_specification.value, "predefined_metric_pair_specification", null) != null ? [metric_specification.value.predefined_metric_pair_specification] : []
            content {
              predefined_metric_type = predefined_metric_pair_specification.value.predefined_metric_type
              resource_label         = predefined_metric_pair_specification.value.resource_label
            }
          }

          dynamic "predefined_scaling_metric_specification" {
            for_each = lookup(metric_specification.value, "predefined_scaling_metric_specification", null) != null ? [metric_specification.value.predefined_scaling_metric_specification] : []
            content {
              predefined_metric_type = predefined_scaling_metric_specification.value.predefined_metric_type
              resource_label         = predefined_scaling_metric_specification.value.resource_label
            }
          }
        }
      }
    }
  }
}
