#alb target group
resource "aws_alb_target_group" "user30-alb-tg" {
    name = "user30-alb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.user30-vpc.id
    health_check {
        interval = 30
        path = "/"
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
    tags = { Name = "user30-Frontend Target Group" }
}
