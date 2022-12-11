resource "aws_security_group" "eks_cluster" {
  count       = var.cluster_count

  name        = "${var.cluster_sg_name}-${count.index}"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.cluster_sg_name
  }
}

resource "aws_security_group_rule" "cluster_inbound" {
  count                    = var.cluster_count

  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster[count.index].id
  source_security_group_id = aws_security_group.eks_nodes[count.index].id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_outbound" {
  count                    = var.cluster_count

  description              = "Allow cluster API Server to communicate with the worker nodes"
  from_port                = 1024
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster[count.index].id
  source_security_group_id = aws_security_group.eks_nodes[count.index].id
  to_port                  = 65535
  type                     = "egress"
}
