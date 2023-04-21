data "aws_region" "present" {}

data "aws_vpc" "self" {}

data "aws_route_table" "private_rt" {
  vpc_id = local.vpc_id
  route_table_id = var.private_route_table_id
}

locals {
  vpc_id     = data.aws_vpc.self.id
  aws_region = data.aws_region.present.name
  private_route_table_id = data.aws_route_table.private_rt.id

  common_tags = {
    Name        = "dev"
    application = "sjit"
  }
}


# igw for public subnet

resource "aws_internet_gateway" "ig" {
  vpc_id= local.vpc_id


  tags = local.common_tags
}

# eip for ngw
resource "aws_eip" "nat_eip" {
  vpc   = true
  depends_on = [aws_internet_gateway.ig]
}


#ngw for private subnet
resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.ig]

  tags = local.common_tags
}

#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = local.common_tags
}

#private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.private_subnet_cidr
  availability_zone      = var.availability_zone
  map_public_ip_on_launch = false

  tags = local.common_tags
}

#route table to public
resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  tags = local.common_tags
}

#route table to private
resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  tags = local.common_tags
}

#route for igw
resource "aws_route" "public_internet-gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}


#route for ngw
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ng.id
}

#route table association for public&private
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

#default security_group of vpc
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "allow trffic from vpc"
  vpc_id      = local.vpc_id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  tags = local.common_tags
}