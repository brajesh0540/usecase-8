resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-fargate-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family = "app-task"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name      = "appointment-service"
      image     = var.image_id
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "patient-service"
      image     = var.image_id
      cpu       = 10
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])
}


  resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "appointment-service"
    container_port   = var.container_port
  }
  depends_on = [aws_lb_listener.ecs_listener]
}

