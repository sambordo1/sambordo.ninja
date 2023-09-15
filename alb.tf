resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for EC2 instance and ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
    ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ninja-security-group"
  }
}


resource "aws_alb" "my_alb" {
  name               = "my-alb"
  subnets            = [var.subnet_id1, var.subnet_id2, var.subnet_id3]
  security_groups    = [aws_security_group.my_security_group.id]
  internal           = false
  load_balancer_type = "application"

  tags = {
    Name = "ninja-alb"
  }
}

resource "aws_alb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "ninja-target-group"
  }
}

resource "aws_alb_listener" "my_listener" {
  load_balancer_arn = aws_alb.my_alb.arn
  port              = 4000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.my_target_group.arn
  }
}

resource "aws_autoscaling_attachment" "my_attachment" {
  autoscaling_group_name = aws_autoscaling_group.my_auto_scaling_group.name
  lb_target_group_arn    = aws_alb_target_group.my_target_group.arn
}