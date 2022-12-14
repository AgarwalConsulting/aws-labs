output "participant_creds" {
  value = tolist([
    for i in range(local.user_count):
      tomap({
        "email" = var.user_emails[i],
        "account_id" = aws_iam_user.participants[i].unique_id,
        "access_key_id" =  aws_iam_access_key.participants[i].id,
        "secret" = aws_iam_access_key.participants[i].secret,
        "arn" = aws_iam_user.participants[i].arn
      })
  ])
  sensitive = true
}
