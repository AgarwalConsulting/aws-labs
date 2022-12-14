output "participant_creds" {
  value = tolist([
    for i in range(local.user_count):
      tomap({
        "email" = var.user_emails[i],
        "access_key_id" =  aws_iam_access_key.participants[i].id,
        "secret" = aws_iam_access_key.participants[i].secret,
        "arn" = aws_iam_user.participants[i].arn,
        "eks_cluster_name" = "${var.eks_cluster_name}-${format("%02d", i + 1)}"
      })
  ])
  sensitive = true
}
