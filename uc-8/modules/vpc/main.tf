resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "${var.vpc_name}"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
  
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public_subnet[0].id
  
}

resource "aws_eip" "eip_nat" {
  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}


resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets )
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
  
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index + 2}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
}

data "aws_availability_zones" "available" {
  state = "available"
}

