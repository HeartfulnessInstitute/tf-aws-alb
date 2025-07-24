output "alb_arn" {
  value = aws_lb.load_balancer.arn
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.load_balancer.dns_name
}

output "target_group_arn" {
  value =  aws_lb_target_group.app_tg.arn
}

