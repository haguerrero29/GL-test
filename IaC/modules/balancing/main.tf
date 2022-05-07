resource "aws_alb" "gl_timeoff_alb" {
  name               = "gl-timeoff-alb"
  subnets            = var.vpc_subnets_id
  security_groups    = [var.security_group]

  enable_deletion_protection = true
  drop_invalid_header_fields = true


  tags = {
    Name = "gl-timeoff-alb"
  }
}

resource "aws_alb_target_group" "gl_timeoff_tg" {
  name        = "gl-timeoff-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "gl_timeoff_http_listener" {
  load_balancer_arn = aws_alb.gl_timeoff_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "gl_timeoff_https_listener" {
  load_balancer_arn = aws_alb.gl_timeoff_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-west-2:271592211585:certificate/9e77c62b-6e6d-4220-8e6f-e633a578e51d"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.gl_timeoff_tg.arn
  }
}