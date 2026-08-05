# aws-autoscaling-policy

Terraform module to create an AWS Auto Scaling Policy supporting all four policy types: **SimpleScaling**, **StepScaling**, **TargetTrackingScaling**, and **PredictiveScaling**.

## Usage

### Simple Scaling


module "asg_policy" {
  source = "./modules/autoscaling-policy"

  name                   = "my-simple-scale-out"
  autoscaling_group_name = "my-asg"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 2
  cooldown               = 300

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}


### Step Scaling


module "asg_policy" {
  source = "./modules/autoscaling-policy"

  name                   = "my-step-scale-out"
  autoscaling_group_name = "my-asg"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"
  metric_aggregation_type = "Average"
  estimated_instance_warmup = 60

  step_adjustments = [
    {
      scaling_adjustment          = 1
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 20
    },
    {
      scaling_adjustment          = 2
      metric_interval_lower_bound = 20
    }
  ]

  tags = {
    Environment = "production"
  }
}


### Target Tracking Scaling (Predefined Metric)


module "asg_policy" {
  source = "./modules/autoscaling-policy"

  name                   = "my-target-tracking"
  autoscaling_group_name = "my-asg"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 60

  target_tracking_configuration = {
    target_value           = 50.0
    predefined_metric_type = "ASGAverageCPUUtilization"
    disable_scale_in       = false
  }

  tags = {
    Environment = "production"
  }
}


### Target Tracking Scaling (Custom Metric)


module "asg_policy" {
  source = "./modules/autoscaling-policy"

  name                   = "my-custom-target-tracking"
  autoscaling_group_name = "my-asg"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration = {
    target_value = 100.0
    customized_metric_specification = {
      metric_name = "RequestCountPerTarget"
      namespace   = "AWS/ApplicationELB"
      statistic   = "Sum"
      metric_dimensions = [
        { name = "TargetGroup", value = "targetgroup/my-tg/abc123" }
      ]
    }
  }

  tags = {
    Environment = "production"
  }
}


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the Auto Scaling policy | `string` | — | yes |
| autoscaling_group_name | Name of the Auto Scaling group | `string` | — | yes |
| policy_type | Policy type: SimpleScaling, StepScaling, TargetTrackingScaling, PredictiveScaling | `string` | `"SimpleScaling"` | no |
| adjustment_type | ChangeInCapacity, ExactCapacity, or PercentChangeInCapacity | `string` | `null` | no |
| scaling_adjustment | Number of instances to scale (SimpleScaling) | `number` | `null` | no |
| cooldown | Cooldown period in seconds (SimpleScaling) | `number` | `300` | no |
| estimated_instance_warmup | Warmup time in seconds (StepScaling/TargetTracking) | `number` | `null` | no |
| min_adjustment_magnitude | Minimum instances to scale for PercentChangeInCapacity | `number` | `null` | no |
| metric_aggregation_type | Aggregation type for StepScaling | `string` | `"Average"` | no |
| step_adjustments | Step adjustment list for StepScaling | `list(object)` | `[]` | no |
| target_tracking_configuration | Target tracking config object | `any` | `{}` | no |
| predictive_scaling_configuration | Predictive scaling config object | `any` | `{}` | no |
| tags | Map of tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Policy ID |
| name | Policy name |
| arn | Policy ARN |
| autoscaling_group_name | Attached ASG name |
| policy_type | Policy type |
| adjustment_type | Adjustment type |
