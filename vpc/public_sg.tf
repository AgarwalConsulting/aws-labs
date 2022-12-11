# Security group for public subnet resources
resource "aws_security_group" "public_sg" {
  count  = var.cluster_count
  name   = "public-sg-${count.index}"
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "public-sg-${count.index}"
  }
}

# Security group traffic rules
## Ingress rule
resource "aws_security_group_rule" "sg_ingress_public_443" {
  count             = var.cluster_count

  security_group_id = aws_security_group.public_sg[count.index].id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_ingress_public_80" {
  count             = var.cluster_count

  security_group_id = aws_security_group.public_sg[count.index].id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

## Egress rule
resource "aws_security_group_rule" "sg_egress_public" {
  count             = var.cluster_count

  security_group_id = aws_security_group.public_sg[count.index].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
