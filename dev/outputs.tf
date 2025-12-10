# Dev Outputs for ALB Module
# Sandbox Account: 502390415551

output "dev_alb_arn" {
  description = "ARN of the dev ALB"
  value       = module.dev_alb.alb_arn
}

output "dev_alb_dns_name" {
  description = "DNS name of the dev ALB"
  value       = module.dev_alb.alb_dns_name
}

output "dev_alb_zone_id" {
  description = "Zone ID of the dev ALB"
  value       = module.dev_alb.alb_zone_id
}

output "dev_http_listener_arn" {
  description = "HTTP listener ARN for dev ALB"
  value       = module.dev_alb.http_listener_arn
}

output "dev_https_listener_arn" {
  description = "HTTPS listener ARN for dev ALB"
  value       = module.dev_alb.https_listener_arn
}

output "dev_alb_sg_id" {
  description = "Security group ID of the dev ALB"
  value       = module.dev_alb.alb_sg_id
}

output "dev_certificate_arn" {
  description = "ACM certificate ARN for dev"
  value       = module.dev_alb.certificate_arn
}

output "dev_validation_records" {
  description = "DNS validation records for ACM certificate"
  value       = module.dev_alb.validation_records
}
