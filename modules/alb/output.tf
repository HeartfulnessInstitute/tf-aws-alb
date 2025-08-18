output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.load_balancer.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.load_balancer.dns_name
}

output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.load_balancer.id
}
