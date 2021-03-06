# Role de security group para acesso external to internal na porta 443
resource "aws_security_group_rule" "eks_sg_ingress_rule" {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
    # Tipo de regra para internal to external utilizar "egress"
    type = "ingress"
}

resource "aws_security_group_rule" "eks_sg_ingress_rule_http" {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
    # Tipo de regra para internal to external utilizar "egress"
    type = "ingress"
}