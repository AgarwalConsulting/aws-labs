module "user_accounts" {
  source = "./users"

  eks_cluster_name = var.cluster_name

  user_emails = var.user_emails
}

# VPC for EKS
module "vpc_for_eks" {
  source = "./vpc"

  cluster_count = length(var.user_emails)
  # cluster_count = var.cluster_count

  eks_cluster_name = var.cluster_name
  vpc_tag_name = "${var.cluster_name}-vpc"
  region = var.region
  availability_zones = var.availability_zones
}

# EKS Cluster
module "eks_cluster_and_worker_nodes" {
  source = "./eks"

  cluster_count = length(var.user_emails)
  # cluster_count = var.cluster_count

  # Cluster
  vpc_id = module.vpc_for_eks.vpc_id
  cluster_sg_name = "${var.cluster_name}-cluster-sg"
  nodes_sg_name = "${var.cluster_name}-node-sg"
  eks_cluster_name = var.cluster_name

  # Node group configuration (including autoscaling configurations)
  pvt_desired_size = 1
  pvt_max_size = 2
  pvt_min_size = 1
  pblc_desired_size = 1
  pblc_max_size = 2
  pblc_min_size = 1
  endpoint_private_access = true
  endpoint_public_access = true
  node_group_name = "${var.cluster_name}-node-group"
  private_subnet_ids = module.vpc_for_eks.private_subnet_ids
  public_subnet_ids = module.vpc_for_eks.public_subnet_ids
}
