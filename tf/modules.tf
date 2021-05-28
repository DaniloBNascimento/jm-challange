# Instanciado o módulo network
module "network" {
  # source directory do módulo
  source = "./modules/network"
  # variáveis utilizadas
  cluster_name = var.cluster_name
  region = var.region
}

module "control_plane" {
  source = "./modules/control_plane"

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b
}

module "nodes" {
  source = "./modules/nodes"
  cluster_name = module.control_plane.cluster_name

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b

}