output "alb_id" {
  description = "The ID of the load balancer"
  value       = aws_lb.this.id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb.this.arn_suffix
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer (to be used in Route 53 alias records)"
  value       = aws_lb.this.zone_id
}

output "security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}

output "security_group_arn" {
  description = "The ARN of the ALB security group"
  value       = aws_security_group.alb_sg.arn
}

output "security_group_name" {
  description = "The name of the ALB security group"
  value       = aws_security_group.alb_sg.name
}
