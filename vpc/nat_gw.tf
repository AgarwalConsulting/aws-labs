# Create Elastic IP
resource "aws_eip" "main" {
  count            = var.cluster_count
  vpc              = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "main" {
  count         = var.cluster_count
  allocation_id = aws_eip.main[count.index].id
  subnet_id     = element(aws_subnet.public_subnet, count.index * length(var.availability_zones)).id

  tags = {
    Name = "NAT Gateway for Custom Kubernetes Cluster"
  }
}

# TODO: Is this even required to be set up?
# Add route to route table
resource "aws_route" "main" {
  route_table_id            = aws_vpc.custom_vpc.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main[0].id
}
