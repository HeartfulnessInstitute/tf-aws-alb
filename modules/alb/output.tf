output "alb_arn" {
  value       = aws_lb.alb_hfn_dev.arn
  description = "The ARN of the ALB"
}

output "alb_dns_name" {
  value       = aws_lb.alb_hfn_dev.dns_name
  description = "The DNS name of the ALB"
}

output "target_group_arn" {
  value       = aws_lb_target_group.hfn_sm_pvt.arn
  description = "Target group ARN"
}
