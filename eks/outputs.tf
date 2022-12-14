output "cluster_names" {
  value = aws_eks_cluster.main.*.name
}
