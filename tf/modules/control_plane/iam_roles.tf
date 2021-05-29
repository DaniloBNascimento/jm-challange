# Criando role para criação do cluster
resource "aws_iam_role" "eks_control_plane_role" {

  name = format("%s-control-plane-role", var.cluster_name)
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
            Service = "eks.amazonaws.com"
        }
    }]
  })

}

# Atachando policys de acordo com a role criada logo acima
resource "aws_iam_role_policy_attachment" "eks_cluster_cluster" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks_control_plane_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_service" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role = aws_iam_role.eks_control_plane_role.name
}