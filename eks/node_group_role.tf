#https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html

resource "aws_iam_role" "eks_nodes" {
  count                = var.cluster_count
  name                 = "${var.eks_cluster_name}-worker-${count.index}"

  assume_role_policy = data.aws_iam_policy_document.assume_workers.json
}

data "aws_iam_policy_document" "assume_workers" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "aws_eks_worker_node_policy" {
  count      = var.cluster_count

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes[count.index].name
}

resource "aws_iam_role_policy_attachment" "aws_eks_cni_policy" {
  count      = var.cluster_count

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes[count.index].name
}

resource "aws_iam_role_policy_attachment" "ec2_read_only" {
  count      = var.cluster_count

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes[count.index].name
}
