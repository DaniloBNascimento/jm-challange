# Provisionando recursos de um grupo de nós para o EKS
resource "aws_eks_node_group" "eks_node_group" {
    
  cluster_name    = var.cluster_name
  node_group_name = format("%s-node-group", var.cluster_name)
  node_role_arn   = aws_iam_role.eks_node_role.arn
  instance_types = ["t2.micro"]

# Atribuindo subnets criadas no módulo de network
  subnet_ids = [
    var.private_subnet_1a, 
    var.private_subnet_1b
  ]

# Configuração de auto scaling
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

# Declarando depedências de permissões para criação do cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly
  ]

}