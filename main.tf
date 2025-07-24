provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ACM Certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = var.acm_domain_name
  validation_method = "DNS"
  tags              = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 Record for Validation
resource "aws_route53_record" "cert_validation" {
  count   = length(aws_acm_certificate.cert.domain_validation_options)
  zone_id = var.route53_zone_id

  name    = tolist(aws_acm_certificate.cert.domain_validation_options)[count.index].resource_record_name
  type    = tolist(aws_acm_certificate.cert.domain_validation_options)[count.index].resource_record_type
  records = [tolist(aws_acm_certificate.cert.domain_validation_options)[count.index].resource_record_value]
  ttl     = 300
}


# Certificate Validation
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Load Balancer
resource "aws_lb" "load_balancer" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout
  tags                       = var.tags
}

# Default Target Group
resource "aws_lb_target_group" "default" {
  name        = "${var.name}-default"
  port        = var.default_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = "/"
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = var.tags
}

# API Target Group
resource "aws_lb_target_group" "api_tg" {
  name        = "${var.name}-api"
  port        = var.api_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = "/health"
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = var.tags
}

# APP Target Group
resource "aws_lb_target_group" "app_tg" {
  name        = "${var.name}-app"
  port        = var.app_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = "/health"
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = var.tags
}

# target group attachment to ec2
resource "aws_lb_target_group_attachment" "api_attachment" {
  count            = length(var.api_instance_ids)
  target_group_arn = aws_lb_target_group.api_tg.arn
  target_id        = var.api_instance_ids[count.index]
  port             = var.api_port
}

resource "aws_lb_target_group_attachment" "app_attachment" {
  count            = length(var.app_instance_ids)
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = var.app_instance_ids[count.index]
  port             = var.app_port
}

# HTTPS Listener
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }

  depends_on = [aws_acm_certificate_validation.cert_validation]
}

# HTTP Listener: redirect to HTTPS
resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Listener Rule: /api/* + Host = api.example.com
resource "aws_lb_listener_rule" "api_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg.arn
  }

  condition {
    host_header {
      values = ["api.${var.domain_name}"]
    }
  }

  condition {
    path_pattern {
      values = ["/v1/*"]
    }
  }
}

# Listener Rule: /app/* + Host = app.example.com
resource "aws_lb_listener_rule" "app_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  condition {
    host_header {
      values = ["app.${var.domain_name}"]
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
