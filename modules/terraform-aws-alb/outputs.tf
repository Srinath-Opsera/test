output "lb_id" {
  description = "ID of the application load balancer."
  value       = aws_lb.this.id
}

output "lb_arn" {
  description = "ARN of the application load balancer."
  value       = aws_lb.this.arn
}

output "lb_dns_name" {
  description = "DNS name of the load balancer."
  value       = aws_lb.this.dns_name
}

output "lb_zone_id" {
  description = "Route53 zone ID for alias records."
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "ARN of the default target group."
  value       = aws_lb_target_group.this.arn
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener."
  value       = aws_lb_listener.https.arn
}
