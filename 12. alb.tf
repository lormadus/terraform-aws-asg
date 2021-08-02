resource "aws_alb" "user30-alb" {
    name = "user30-alb"
    internal = false
    security_groups = [aws_security_group.user30-alb-sg.id]
    subnets = [
        aws_subnet.user30-subnet1.id,
        aws_subnet.user30-subnet2.id
    ]
    access_logs {
        bucket = aws_s3_bucket.user30-s3.id
        prefix = "user30-alb"
        enabled = true
    }
    tags = {
        Name = "user30-alb"
    }
    lifecycle { create_before_destroy = true }
}

resource "aws_alb_listener" "http" {
    load_balancer_arn = aws_alb.user30-alb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        target_group_arn = aws_alb_target_group.user30-alb-tg.arn
        type = "forward"
    }
}
