resource "aws_lb" "this" {
  name                       = var.load_balancer_name
  internal                   = var.internal
  load_balancer_type         = "application"
  subnets                    = var.subnets
  security_groups            = var.security_groups
  enable_deletion_protection = var.enable_deletion_protection
  ip_address_type            = "ipv4"

  tags = merge(
    var.tags,
    { Name = var.load_balancer_name }
  )
}

# HTTP -> HTTPS
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
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

# HTTPS
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
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

# Target Groups
resource "aws_lb_target_group" "this" {
  for_each = var.applications

  name        = each.value.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = lookup(each.value, "health_check_path", "/healthy.html")
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200,404"
  }
}

# Listener Rules
resource "aws_lb_listener_rule" "this" {
  for_each     = var.applications
  listener_arn = aws_lb_listener.https.arn
  priority     = each.value.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }

  condition {
    host_header {
      values = [each.value.domain]
    }
  }

  condition {
    path_pattern {
      values = lookup(each.value, "path_patterns", ["/*"])
    }
  }
}

# Attach EC2 Instances
resource "aws_lb_target_group_attachment" "this" {
  for_each = {
    for app, cfg in var.applications :
    app => cfg if contains(keys(cfg), "target_ids")
  }

  target_group_arn = aws_lb_target_group.this[each.key].arn
  target_id        = element(each.value.target_ids, 0)
  port             = 80
}



