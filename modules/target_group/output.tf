output "target_group_arn" {
  value       = aws_lb_target_group.hfn_sm_pvt.arn
  description = "Target group ARN"
}
