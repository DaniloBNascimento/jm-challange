variable "cluster_name" {
  default = "eks-jm"
}

variable "kubernetes_version" {
  default = "1.18"
}

variable "private_subnet_1a" {
  description = "Essa variável não possui valor explícito pois provem do output.tf do módulo network"
}

variable "private_subnet_1b" {
  description = "Essa variável não possui valor explícito pois provem do output.tf do módulo network"
}