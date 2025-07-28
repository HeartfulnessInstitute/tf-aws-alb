resource "aws_lb_target_group" "tg" {
  for_each    = toset(var.port)
  name        = "${var.app_name}-tg-${each.key}"
  port        = each.key
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}


resource "aws_lb_target_group_attachment" "attachments" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_ids[count.index]
  port             = var.port
}
