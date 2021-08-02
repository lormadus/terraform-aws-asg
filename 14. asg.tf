resource "aws_autoscaling_group" "user30-asg" {
  name = "${aws_launch_configuration.user30-asg-launch.name}-asg"

  min_size             = 2
  desired_capacity     = 2
  max_size             = 3

  health_check_type    = "ELB"
  #load_balancers= ["${aws_alb.alb.id}" ] #classic
  target_group_arns   = [aws_alb_target_group.user30-alb-tg.arn]
  #alb = "${aws_alb.alb.id}"
  
  launch_configuration = aws_launch_configuration.user30-asg-launch.name
  
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity="1Minute"

  vpc_zone_identifier  = [
    aws_subnet.user30-subnet1.id,
    aws_subnet.user30-subnet2.id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "user30-web-autoscaling"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "user30-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.user30-asg.id
  alb_target_group_arn   = aws_alb_target_group.user30-alb-tg.arn
}


