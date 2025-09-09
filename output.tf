#Output
output "alb_arn"          { 
    value = aws_lb.lb.arn 
}

output "alb_dns_name"     { 
    value = aws_lb.lb.dns_name 
}

output "alb_zone_id"      { 
    value = aws_lb.lb.zone_id
}

output "http_listener_arn"{
     value = aws_lb_listener.http.arn 
}

output "https_listener_arn" {
  description = "HTTPS listener ARN for ALB"
  value       = aws_lb_listener.https.arn
}

output "alb_sg_id"        { 
    value = aws_security_group.alb.id 
}

output "acm_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "validation_records" {
  value = [
    for dvo in aws_acm_certificate.cert.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}
