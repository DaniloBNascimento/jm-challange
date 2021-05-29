# Criação de um internet gateway para acesso externo e interno
resource "aws_internet_gateway" "eks_internet_gw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = format("%s-internet-gateway", var.cluster_name)
  }

  # Declaração de depedência do recurso principal (VPC)
  depends_on = [ aws_vpc.eks_vpc ]
}

# Criação de uma tabela de rota para acesso público
resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_internet_gw.id
  }

  tags = {
    Name = format("%s-public-route-table", var.cluster_name)
  }
  depends_on = [ aws_vpc.eks_vpc, aws_internet_gateway.eks_internet_gw ]
}