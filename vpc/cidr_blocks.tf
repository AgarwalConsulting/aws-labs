// TODO: Improve this calculation
locals {
  private_subnet_cidr_blocks = [for i in range(var.cluster_count) : ["10.0.${(i * 4) + 0}.0/24", "10.0.${(i * 4) + 1}.0/24"]]

  public_subnet_cidr_blocks = [for i in range(var.cluster_count) : ["10.0.${(i * 4) + 2}.0/24", "10.0.${(i * 4) + 3}.0/24"]]
}
