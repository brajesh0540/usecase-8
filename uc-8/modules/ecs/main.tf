resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task" {
  for_each = var.services
  family = "${var.cluster_name}-${each.key}"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = each.value.cpu
  memory = each.value.memory
  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_arn_role

  container_definitions = jsonencode([
    {
      name      = each.key
      image     = "${each.value.image}:latest"
      portMappings = [
        {
          containerPort = each.value.container_port
          hostPort      = each.value.container_port
          protocol      = "tcp"
        }
      ]
      essential = true
    }
  ])
}

  resource "aws_ecs_service" "ecs_service" {
  for_each = var.services
  name            = each.key
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task[each.key].arn
  desired_count   = 0
network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = true
  }

load_balancer {
    target_group_arn = var.ecs_target_group_arn
    container_name   = each.key
    container_port   = each.value.container_port

  }
depends_on = [ aws_ecs_task_definition.task ]

}

