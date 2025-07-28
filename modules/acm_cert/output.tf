output "acm_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate.cert.arn
}
