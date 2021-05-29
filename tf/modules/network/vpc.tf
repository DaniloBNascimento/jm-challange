# Código para criação de uma VPC na AWS para uso do cluster EKS
resource "aws_vpc" "eks_vpc" {
  cidr_block            = "10.0.0.0/16"

  enable_dns_hostnames  = true
  enable_dns_support    = true

# Adicionando uma tag ao recurso com o nome + string concatenada -eks-vpc para identificar onde a VPC está sendo usada
  tags = {
    Name = format("%s-eks-vpc",var.cluster_name)
  }
}