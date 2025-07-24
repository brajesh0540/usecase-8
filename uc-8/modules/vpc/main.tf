resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs_security_group"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    }
}

resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
}

resource "aws_subnet" "Private_subnet" {
  count = 2
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index + 2}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
}

data "aws_availability_zones" "available" {
  state = "available"
}

