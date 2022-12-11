#https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html

resource "aws_iam_role" "eks_cluster" {
  count = var.cluster_count
  name  = "${var.eks_cluster_name}-cluster-${count.index}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws_eks_cluster_policy" {
  count      = var.cluster_count

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks_cluster[count.index].name}"
}
