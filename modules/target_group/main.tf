
resource "aws_lb_target_group" "hfn_sm_pvt" {
  name        = "HFN-SM-PVT-TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

# HTTP -> HTTPS redirect
resource "aws_lb_listener" "http" {
  load_balancer_arn = var.alb_arn
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
  load_balancer_arn = var.alb_arn
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

resource "aws_lb_listener_rule" "https_rule1" {
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
      values = ["stagecare.heartfulness.org"]
    }
  }
}

resource "aws_lb_target_group_attachment" "care_server_attachment" {
  target_group_arn = aws_lb_target_group.hfn_sm_pvt.arn
  target_id        = "i-00af2e73a2a19774e"
  port             = 80
}

# Local Variables
/*locals {
  common_tags = {
    Environment = var.environment
    Project     = "hfn-project"
    alb_name    = "ALB-HFN-dev"
    app_name    = "myapp"
  }

  idle_timeout_by_env = {
    dev     = 60
    staging = 90
    prod    = 120
  }

  idle_timeout = lookup(local.idle_timeout_by_env, var.environment, 60)
}

# Get Existing ALB by Name
data "aws_lb" "existing_alb" {
  name = local.common_tags.alb_name
}

resource "aws_lb_target_group" "tg" {
  for_each = toset([for p in var.port : tostring(p)])

  name     = "${var.app_name}-${each.key}"
  port     = each.key
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.health_check_path
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "attachments" {
  for_each = {
    for pair in setproduct(var.instance_ids, var.port) :
    "${pair[0]}-${pair[1]}" => {
      instance_id = pair[0]
      port        = pair[1]
    }
  }

  target_group_arn = aws_lb_target_group.tg[each.value.port].arn
  target_id        = each.value.instance_id
  port             = each.value.port
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = data.aws_lb.existing_alb.arn
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

data "aws_acm_certificate" "cert" {
  domain   = "dev.heartfulness.org"  
  statuses = ["ISSUED"]
  most_recent = true
}

output "acm_certificate_arn" {
  value = data.aws_acm_certificate.cert.arn
}

 resource "aws_lb_listener" "https" {
   load_balancer_arn = data.aws_lb.existing_alb.arn
   port              = 443
   protocol          = "HTTPS"
   ssl_policy        = "ELBSecurityPolicy-2016-08"
   certificate_arn = data.aws_acm_certificate.cert.arn



   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.tg[80].arn  
   }
 }

 resource "aws_lb_listener_rule" "rule" {
   listener_arn = aws_lb_listener.https.arn   
   priority     = var.priority

   action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.tg[80].arn  
   }

   condition {
     host_header {
       values = [var.host]
     }
   }

   condition {
     path_pattern {
       values = [var.path_pattern]
     }
   }
 }*/
