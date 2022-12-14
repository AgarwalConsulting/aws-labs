resource "aws_iam_user" "participants" {
  count = local.user_count

  name = "participants-${format("%02d", count.index + 1)}"
  path = "/participants/"
}

resource "aws_iam_access_key" "participants" {
  count = local.user_count

  user = aws_iam_user.participants[count.index].name
}

resource "aws_iam_user_policy" "eks_console" {
  count = local.user_count

  name = "eks_policy"
  user = aws_iam_user.participants[count.index].name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": "eks.amazonaws.com"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "eks_ro" {
  count = local.user_count

  name = "eks_policy"
  user = aws_iam_user.participants[count.index].name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:DescribeCluster",
        "eks:ListClusters"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# An error occurred (AccessDeniedException) when calling the DescribeCluster operation: User: arn:aws:iam::487175281388:user/participants/participants-0 is not authorized to perform: eks:DescribeCluster on resource: arn:aws:eks:us-east-1:487175281388:cluster/eks-101-0
