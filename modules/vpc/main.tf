# Resource for creating a private subnet within the default VPC
resource "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.default.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = "Default VPC Private Subnet"
  }
}

# Resource for creating a route table for the private subnet, without an internet route
resource "aws_route_table" "private_route_table" {
  vpc_id = data.aws_vpc.default.id
}

# Resource for associating the private subnet with the private route table
resource "aws_route_table_association" "private_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
