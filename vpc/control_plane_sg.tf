# Security group for control plane
resource "aws_security_group" "control_plane_sg" {
  count = var.cluster_count

  name   = "k8s-control-plane-sg-${count.index}"
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "k8s-control-plane-sg-${count.index}"
  }
}

# Security group traffic rules
## Ingress rule
resource "aws_security_group_rule" "control_plane_inbound" {
  count               = var.cluster_count

  security_group_id   = aws_security_group.control_plane_sg[count.index].id
  type                = "ingress"

  from_port           = 0
  to_port             = 65535

  protocol            = "tcp"
  cidr_blocks         = flatten([local.private_subnet_cidr_blocks[count.index], local.public_subnet_cidr_blocks[count.index]])
}

## Egress rule
resource "aws_security_group_rule" "control_plane_outbound" {
  count               = var.cluster_count

  security_group_id   = aws_security_group.control_plane_sg[count.index].id
  type                = "egress"
  from_port           = 0
  to_port             = 65535
  protocol            = "-1"
  cidr_blocks         = ["0.0.0.0/0"]
}
