resource "aws_eip" "eks_elastic_ip" {
  vpc = true
  
  tags = {
    "Name" = format("%s-elastic-ip", var.cluster_name)
  }
  depends_on = [ aws_vpc.eks_vpc ]
}

resource "aws_nat_gateway" "eks_nat_gw" {
  allocation_id = aws_eip.eks_elastic_ip.id
  subnet_id     = aws_subnet.eks_subnet_public_az_1a.id

  tags = {
    Name = format("%s-nat-gateway", var.cluster_name)
  }
  depends_on = [ aws_vpc.eks_vpc, aws_subnet.eks_subnet_public_az_1a ]
}

resource "aws_route_table" "eks_nat_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gw.id
  }

  tags = {
    Name = format("%s-private-rt", var.cluster_name)  
  }
  depends_on = [ aws_vpc.eks_vpc, aws_nat_gateway.eks_nat_gw ]
}