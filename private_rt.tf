resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "eip-nat_${var.vpc_name}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = element(aws_subnet.public_subnets.*.id, 0)

  tags = {
    Name = "nat_${var.vpc_name}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private_rt_${var.vpc_name}"
  }
}