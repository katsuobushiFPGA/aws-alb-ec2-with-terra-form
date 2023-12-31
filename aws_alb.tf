resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.web.id]
  subnets         = [aws_subnet.public_subnet.id, aws_subnet.public_dummy_subnet.id]
}

resource "aws_lb_target_group" "alb_target" {
  name     = "target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_lb_target_group_attachment" "private_ec2" {
  target_group_arn = aws_lb_target_group.alb_target.arn
  target_id        = aws_instance.private_app_server.id
  port             = 80
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}