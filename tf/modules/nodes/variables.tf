variable "cluster_name" {
  default = "test-eks"
}

variable "desired_size" {
  default = 4
}

variable "max_size" {
  default = 4
}

variable "min_size" {
  default = 4
}

variable "private_subnet_1a" {
  description = "Essa variável não possui valor explícito pois provem do output.tf do módulo network"
}

variable "private_subnet_1b" {
  description = "Essa variável não possui valor explícito pois provem do output.tf do módulo network"
}