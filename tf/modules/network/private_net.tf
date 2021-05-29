# Criação dos recursos de subnet para a VPC, por padrão o EKS necessita de 2 para alta disponibilidade

# Subnet na AZ 1 de acordo com a region
resource "aws_subnet" "eks_subnet_private_az_1a" {

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = format("%sa", var.region)

  tags = {
    Name = format("%s-subnet-private-az-1a", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
  depends_on = [ aws_vpc.eks_vpc ]
}

# Subnet na AZ 2 de acordo com a region
resource "aws_subnet" "eks_subnet_private_az_1b" {

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = format("%sb", var.region)

  tags = {
    Name = format("%s-subnet-private-az-1b", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
  depends_on = [ aws_vpc.eks_vpc ]
}

# Atachando regras de roteamento para AZ 1
resource "aws_route_table_association" "eks_private_route_table_az_1a" {
  subnet_id      = aws_subnet.eks_subnet_private_az_1a.id
  route_table_id = aws_route_table.eks_nat_route_table.id
}

# Atachando regras de roteamento para AZ 2
resource "aws_route_table_association" "eks_private_route_table_az_1b" {
  subnet_id      = aws_subnet.eks_subnet_private_az_1b.id
  route_table_id = aws_route_table.eks_nat_route_table.id
}