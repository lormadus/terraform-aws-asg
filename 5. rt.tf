resource "aws_route_table" "user30-rt" {
  vpc_id = aws_vpc.user30-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.user30-igw.id
  }

  tags = {
    Name = "user30-rt"
  }
}


resource "aws_route_table_association" "rt_subnet1" {
  subnet_id      = aws_subnet.user30-subnet1.id
  route_table_id = aws_route_table.user30-rt.id
}

resource "aws_route_table_association" "rt_subnet2" {
  subnet_id      = aws_subnet.user30-subnet2.id
  route_table_id = aws_route_table.user30-rt.id
}
