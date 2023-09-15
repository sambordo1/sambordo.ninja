resource "aws_launch_configuration" "my_launch_configuration" {
  name_prefix          = "my-launch-configuration-"
  image_id             = var.ec2_ami
  instance_type        = var.ec2_instance_type
  security_groups      = [aws_security_group.my_security_group.id]
  key_name             = var.key_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_auto_scaling_group" {
  name                      = "my-auto-scaling-group"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  launch_configuration      = aws_launch_configuration.my_launch_configuration.name
  vpc_zone_identifier       = [var.subnet_id1]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns          = [aws_alb_target_group.my_target_group.arn]

  tag {
    key                 = "Name"
    value               = "ninja-ec2-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "production"
    propagate_at_launch = true
  }
}