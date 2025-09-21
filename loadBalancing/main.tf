resource "aws_lb_target_group" "tg_a" { 

    name     = var.targetName-a
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc-cidr

}
resource "aws_lb_target_group" "tg_b" { 

    name     = var.targetName-b
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc-cidr

}
resource "aws_lb_target_group_attachment" "tg_attachment_a" {

    target_group_arn = aws_lb_target_group.tg_a.arn
    target_id        = var.instance_id_zone_a
    port             = 80

}
resource "aws_lb_target_group_attachment" "tg_attachment_b" {

    target_group_arn = aws_lb_target_group.tg_b.arn
    target_id        = var.instance_id_zone_b
    port             = 80

}
resource "aws_lb" "my_alb" {

    name               = var.name
    internal           = var.internal
    load_balancer_type = "application"
    security_groups    = [var.alb_sg]
    subnets            = [var.subnet_a, var.subnet_b]
    tags = {    
      Environment = "dev"   
    }

}
resource "aws_lb_listener" "HTTPRoutes" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.tg_a.arn
        weight = 50
      }
      target_group {
        arn    = aws_lb_target_group.tg_b.arn
        weight = 50
      }
    }
  }
  depends_on = [
    aws_lb_target_group.tg_a,
    aws_lb_target_group.tg_b
  ]
}

