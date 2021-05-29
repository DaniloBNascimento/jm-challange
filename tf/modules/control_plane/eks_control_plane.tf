# Criação do cluster EKS (control plane and main resources)
resource "aws_eks_cluster" "eks_cluster" {
  # Nome do cluster (alterar variável cluster_name)
  name     = var.cluster_name
  # assume role para criação do cluster e gerenciamento
  role_arn = aws_iam_role.eks_control_plane_role.arn
  # Versão do Kubernetes a ser utilizada (alterar variável kubernetes_version)
  version  = var.kubernetes_version
  
  # Atachando subnets que serão utilizadas pelo cluster
  vpc_config {

      subnet_ids = [
          var.private_subnet_1a, 
          var.private_subnet_1b
      ]
      
  }
  
  # Declaração de depedências das permissões de criação
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_cluster,
    aws_iam_role_policy_attachment.eks_cluster_service
  ]

}