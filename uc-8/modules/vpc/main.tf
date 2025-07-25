resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
}


resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
}

resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index + 2}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
}

data "aws_availability_zones" "available" {
  state = "available"
}

