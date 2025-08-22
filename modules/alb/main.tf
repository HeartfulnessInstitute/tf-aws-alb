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

resource "aws_lb" "alb_hfn_dev" {
  name               = "hfn-care-dev-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  ip_address_type    = "ipv4"

  enable_deletion_protection = false

  tags = {
    Name        = "ALB-HFN-dev"
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "hfn_sm_pvt" {
  name        = "HFN-SM-PVT-TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/admin"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

# HTTP -> HTTPS redirect
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_hfn_dev.arn
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

# HTTPS listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb_hfn_dev.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "No matching rules"
      status_code  = "404"
    }
  }
}


/*resource "aws_lb_listener_rule" "https_rule1" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hfn_sm_pvt.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  condition {
    host_header {
      values = ["dev.heartfulness.org"]
    }
  }
}*/

resource "aws_lb_target_group_attachment" "care_server_attachment" {
  target_group_arn = aws_lb_target_group.hfn_sm_pvt.arn
  target_id        = "i-00af2e73a2a19774e"
  port             = 80
}

