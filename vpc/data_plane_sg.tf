# Security group for data plane
resource "aws_security_group" "data_plane_sg" {
  count = var.cluster_count
  name   = "k8s-data-plane-sg-${count.index}"
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "k8s-data-plane-sg-${count.index}"
  }
}

# Security group traffic rules
## Ingress rule
resource "aws_security_group_rule" "nodes" {
  count                 = var.cluster_count

  description           = "Allow nodes to communicate with each other"
  security_group_id     = aws_security_group.data_plane_sg[count.index].id
  type                  = "ingress"
  from_port             = 0
  to_port               = 65535
  protocol              = "-1"
  cidr_blocks           = flatten([local.private_subnet_cidr_blocks[count.index], local.public_subnet_cidr_blocks[count.index]])
}

resource "aws_security_group_rule" "nodes_inbound" {
  count                    = var.cluster_count

  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  security_group_id        = aws_security_group.data_plane_sg[count.index].id
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  cidr_blocks              = flatten([local.private_subnet_cidr_blocks[count.index]])
}

## Egress rule
resource "aws_security_group_rule" "node_outbound" {
  count                 = var.cluster_count

  security_group_id     = aws_security_group.data_plane_sg[count.index].id
  type                  = "egress"
  from_port             = 0
  to_port               = 0
  protocol              = "-1"
  cidr_blocks           = ["0.0.0.0/0"]
}
