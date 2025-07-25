resource "aws_lb" "ecs_alb" {
    name               = "my-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = var.public_subnet
    
    tags = {
        Name = "my-alb"
        env  = var.env
    }

  
}

resource "aws_lb_target_group" "ecs_target_group" {
    name     = "my-target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "ip"

    health_check {
        path                = "/health"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }

    tags = {
        Name = "my-target-group"
        env  = var.env
    }
}

resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.ecs_alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.ecs_target_group.arn
    }

    tags = {
        Name = "my-listener"
        env  = var.env
    }
  
}