output "target_group_arns" {
  value = { for port, tg in aws_lb_target_group.tg : port => tg.arn }
}
