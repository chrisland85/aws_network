# Step 1 - Define the provider
provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.env}-vpc"
    Env = var.env
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.env}-${element(var.availability_zones, count.index)}-private-subnet"
    Env = "${var.env}"
  }
}


# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.env}-private-route-table"
    Env = "${var.env}"
  }
}

# Route for NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
