# Criando subnets na VPC (eks_vpc) criada no arquivo vpc.tf
# Subnet na AZ 1
resource "aws_subnet" "eks_subnet_public_az_1a" {

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = true

# Atribuindo tag de cluster EKS obrigatória em subnets 
  tags = {
    Name = format("%s-subnet-public-az-1a", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
  depends_on = [ aws_vpc.eks_vpc ]
}

#Subnet na AZ 2
resource "aws_subnet" "eks_subnet_public_az_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-subnet-public-az-1b", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"    
  }
  depends_on = [ aws_vpc.eks_vpc ]
}

# Associando route table a cada subnet
resource "aws_route_table_association" "eks_public_route_table_az_1a" {
  subnet_id      = aws_subnet.eks_subnet_public_az_1a.id
  route_table_id = aws_route_table.eks_public_route_table.id
  depends_on = [ aws_route_table.eks_public_route_table ]
}

resource "aws_route_table_association" "eks_public_route_table_az_1b" {
  subnet_id      = aws_subnet.eks_subnet_public_az_1b.id
  route_table_id = aws_route_table.eks_public_route_table.id
  depends_on = [ aws_route_table.eks_public_route_table ]
}