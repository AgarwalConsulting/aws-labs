resource "aws_eks_cluster" "main" {
  count    = var.cluster_count
  name     = "${var.eks_cluster_name}-${format("%02d", count.index + 1)}" // If this changes, change the tag in the public/private subnets
  role_arn = aws_iam_role.eks_cluster[count.index].arn
  version  = var.kubernetes_version

  vpc_config {
    security_group_ids      = [aws_security_group.eks_cluster[count.index].id, aws_security_group.eks_nodes[count.index].id]

    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access

    subnet_ids = flatten([var.private_subnet_ids, var.public_subnet_ids])
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_cluster_policy
  ]
}
