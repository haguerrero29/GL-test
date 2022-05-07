resource "aws_vpc" "gl_timeoff_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "GL-TimeOff-VPC"
  }
}

resource "aws_internet_gateway" "gl_timeoff_IG" {
  vpc_id = aws_vpc.gl_timeoff_vpc.id
  tags = {
    Name = "GL-TimeOff-IG"
  }
}

resource "aws_subnet" "gl_timeoff_pu_subnet_1" {
  cidr_block = var.gl_timeoff_pu_cidr
  vpc_id = aws_vpc.gl_timeoff_vpc.id
  availability_zone = "${var.region}a"

  tags = {
    Name = "gl_timeoff_pu-subnet-1"
  }
}

resource "aws_subnet" "gl_timeoff_pu_subnet_2" {
  cidr_block = var.gl_timeoff_pu2_cidr
  vpc_id = aws_vpc.gl_timeoff_vpc.id
  availability_zone = "${var.region}b"

  tags = {
    Name = "gl_timeoff_pu-subnet-2"
  }
}

resource "aws_route_table" "gl_timeoff_pu_route_table" {
  vpc_id = aws_vpc.gl_timeoff_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gl_timeoff_IG.id
  }
  tags = {
    Name = "gl-timeoff-pu-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.gl_timeoff_pu_route_table.id
  subnet_id = aws_subnet.gl_timeoff_pu_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.gl_timeoff_pu_route_table.id
  subnet_id = aws_subnet.gl_timeoff_pu_subnet_2.id
}

resource "aws_security_group" "gl_timeoff_http_sg" {

  name = "allow http and https"
  description = "Control access to timeoff"
  vpc_id = aws_vpc.gl_timeoff_vpc.id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}