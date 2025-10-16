output "alb_arn" {
  value       = aws_lb.this.arn
  description = "ALB ARN"
}

output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "ALB DNS name"
}

output "alb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "ALB hosted zone id"
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "Target group arn"
}

output "target_group_id" {
  value       = aws_lb_target_group.this.id
  description = "Target group id"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb_sg.id
  description = "ALB security group id"
}

output "target_sg_id" {
  value       = try(aws_security_group.ec2_sg[0].id, "")
  description = "SG id created for targets (if create_target_sg set)"
}
