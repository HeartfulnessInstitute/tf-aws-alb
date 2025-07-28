resource "aws_acm_certificate" "cert" {
  domain_name       = var.acm_domain_name
  validation_method = "DNS"
  tags              = var.tags

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_route53_record" "cert_validation" {
  count   = length(aws_acm_certificate.cert.domain_validation_options)
  zone_id = var.route53_zone_id

  name    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_type
  records = [aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_value]
  ttl     = 300

  depends_on = [aws_acm_certificate.cert]
}


resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}